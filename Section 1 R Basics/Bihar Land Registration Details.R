# find for last 30 days
library(httr)
library(RCurl)
library(rvest)
N=58010
url = "https://bhoomirashi.gov.in/prep1.asp?nid=1&project_id="
csvPath = "C:\\Users\\Pyuish\\OneDrive\\To Print\\Map\\Road Projects\\"

project_df <- data.frame(ProjectName="NA",ProjectNumber="NA" ,LandRequired="NA" ,LandAvailable="NA" ,LandToBeAcquired="NA" ,LandAcquiredTillNow="NA" ,SanctionNumber="NA" ,SanctionDate="NA" ,SanctionAmount="NA")
project_3a_df <- data.frame(PublishDate="",NotificationNumber="",NotificationFile="",Village="",Staus="",ProjectNumber="")
project_3A_df <- data.frame(PublishDate="",NotificationNumber="",NotificationFile="",SurveyNumber="",Staus="",ProjectNumber="")
project_3D_df <- data.frame(PublishDate="",NotificationNumber="",NotificationFile="",SurveyNumber="",Staus="",ProjectNumber="")

for (i in 58000:N){

  actualURL = gsub(" ","",paste(url,i))
  
  if (http_error(actualURL)){
    print(paste(actualURL,"URL does not exist"))
  } 
  else {
    ## Start by reading a HTML page with read_html():
    webpage <- read_html(actualURL)
    
    ## Then find elements that match a css selector or XPath expression
    ## using html_elements().
    
    ##all details table
    html_tables_data_1 <- webpage %>%html_nodes("table") %>%.[1] %>%
      html_table(fill = T)
    html_tables_frame_1=as.data.frame(html_tables_data_1,check.names = FALSE)
    
    ##project details table
    html_tables_data_2 <- webpage %>%html_nodes("table") %>%.[2] %>%
     html_table(fill = T)
    html_tables_frame_2=as.data.frame(html_tables_data_2,check.names = FALSE)
    
    ##sanction details table
    html_tables_data_3 <- webpage %>%html_nodes("table") %>%.[3] %>%
      html_table(fill = T)
    html_tables_frame_3=as.data.frame(html_tables_data_3)
    
    ##3(a) notifications details table
    html_tables_data_4 <- webpage %>%html_nodes("table") %>%.[4] %>%
     html_table(fill = T)
    html_tables_frame_4=as.data.frame(html_tables_data_4)
    
    ##3A notifications details table
    html_tables_data_5 <- webpage %>%html_nodes("table") %>%.[5] %>%
     html_table(fill = T)
    html_tables_frame_5=as.data.frame(html_tables_data_5)
    
    ##3D notifications details table
    html_tables_data_6 <- webpage %>%html_nodes("table") %>%.[6] %>%
     html_table(fill = T)
    html_tables_frame_6=as.data.frame(html_tables_data_6)
      
    ##project details 
    project_name = html_tables_frame_2[1,3]
    ProjectNumber = html_tables_frame_2[2,3]
    land_required = html_tables_frame_2[3,2]
    land_available = html_tables_frame_2[3,4]
    land_to_be_acquired = html_tables_frame_2[4,2]
    land_acquired = html_tables_frame_2[4,4]
    
    ##sanction details
    html_tables_frame_3$ProjectNumber <- ProjectNumber
    p <- nrow(html_tables_frame_3)
    if(nrow(html_tables_frame_3) > 3)
    {
      sanction_number = html_tables_frame_3[3,1]
      sanction_date = html_tables_frame_3[3,2]
      sanction_amount = html_tables_frame_3[3,3]
    }
    else
    {
      sanction_number = "NA"
      sanction_date = "NA"
      sanction_amount = "NA"
    }
    
    ##3(a) details
    html_tables_frame_4$ProjectNumber <- ProjectNumber
    html_tables_frame_4 <- html_tables_frame_4[-c(6:10)]
    html_tables_frame_4 <- html_tables_frame_4[-c(1:2),]
    colnames(html_tables_frame_4) <- c("PublishDate","NotificationNumber","NotificationFile","Village","Staus","ProjectNumber")
    
    ##3A details 
    html_tables_frame_5$ProjectNumber <- ProjectNumber
    html_tables_frame_5 <- html_tables_frame_5[-c(6:10)]
    html_tables_frame_5 <- html_tables_frame_5[-c(1:2),]
    colnames(html_tables_frame_5) <- c("PublishDate","NotificationNumber","NotificationFile","SurveyNumber","Staus","ProjectNumber")
    
    ##3D details 
    html_tables_frame_6$ProjectNumber <- ProjectNumber
    html_tables_frame_6 <- html_tables_frame_6[-c(6:10)]
    html_tables_frame_6 <- html_tables_frame_6[-c(1:2),]
    colnames(html_tables_frame_6) <- c("PublishDate","NotificationNumber","NotificationFile","SurveyNumber","Staus","ProjectNumber")
    
    project_details_row <- c(project_name, ProjectNumber, land_required, land_available, land_to_be_acquired, land_acquired,sanction_number, sanction_date, sanction_amount)
    project_df <- rbind(project_df,project_details_row)
    project_3a_df <- rbind(project_3a_df,html_tables_frame_4)
    project_3A_df <- rbind(project_3A_df,html_tables_frame_5)
    project_3D_df <- rbind(project_3D_df,html_tables_frame_6)
    
    write.csv(project_df,paste(csvPath,"ProjectDetails.csv"), row.names = FALSE)
    write.csv(project_3a_df,paste(csvPath,"Project3aDetails.csv"), row.names = FALSE)
    write.csv(project_3A_df,paste(csvPath,"Project3ADetails.csv"), row.names = FALSE)
    write.csv(project_3D_df,paste(csvPath,"Project3DDetails.csv"), row.names = FALSE)
    
    #mergecols <- c("ProjectNumber")
    # RAll <- left  <- merge(project_df,
    #                        merge(html_tables_frame_4,
    #                              merge(html_tables_frame_5, html_tables_frame_6, by = mergecols, all.x = TRUE),
    #                              by = mergecols, all.x = TRUE),by = mergecols, all.x = TRUE)

  }
  rm("html_tables_data_1", "html_tables_data_2","html_tables_data_3","html_tables_data_4","html_tables_data_5","html_tables_data_6")
  rm("html_tables_frame_1", "html_tables_frame_2","html_tables_frame_3","html_tables_frame_4","html_tables_frame_5","html_tables_frame_6")
  #rm("webpage","actualURL","land_acquired","land_available","land_required","land_to_be_acquired","N","p","project_details_row","project_name","ProjectNumber","sanction_amount","sanction_date","sanction_number","url","csvPath")
}