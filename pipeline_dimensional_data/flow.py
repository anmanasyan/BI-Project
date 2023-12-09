from pipeline_dimensional_data import tasks 
import utils

from logger import CustomFormatter
import logging

#setting up logging
log_file_path='C:\\Users\\Anna\\Desktop\\BI\\Group_Project_2\\logs\\logs_dimensional_data_pipeline.txt'
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

# Create a FileHandler and set the level to DEBUG
file_handler = logging.FileHandler(log_file_path)
file_handler.setLevel(logging.DEBUG)

# Set the formatter for the FileHandler
file_handler.setFormatter(CustomFormatter())
# Add the FileHandler to the logger
logger.addHandler(file_handler)

class DimensionalDataFlow:
    def __init__(self):
        self.flow_id = utils.generate_unique_uuid()
        logger.info(f"DimensionalDataFlow instance created with UUID: {self.flow_id}")

    def exec(self):
        # Initiating Connection
        conn_ER = tasks.connect_db_create_cursor("Database2")
        '''
        #Deleting tables if they existed
        tasks.drop_table(conn_ER, 'order_details', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.drop_table(conn_ER, 'employees', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.drop_table(conn_ER, 'orders', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.drop_table(conn_ER, 'customers', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.drop_table(conn_ER, 'categories', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.drop_table(conn_ER, 'products', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.drop_table(conn_ER, 'territories', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.drop_table(conn_ER, 'region', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.drop_table(conn_ER, 'shippers', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.drop_table(conn_ER, 'suppliers', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        '''
        
        # Creating all the tables 
        tasks.create_table(conn_ER, 'dim_categories_scd1', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.create_table(conn_ER, 'dim_customers_scd2', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.create_table(conn_ER, 'dim_employees_scd1', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        #tasks.create_table(conn_ER, 'dim_order_details', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.create_table(conn_ER, 'fact_orders', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.create_table(conn_ER, 'dim_products_scd1', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.create_table(conn_ER, 'dim_region_scd1', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.create_table(conn_ER, 'dim_region_scd4_history', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.create_table(conn_ER, 'dim_shippers_scd1', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.create_table(conn_ER, 'dim_suppliers_scd3', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.create_table(conn_ER, 'dim_territories_scd1', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.create_table(conn_ER, 'dim_territories_scd4', 'ORDERS_DIMENSIONAL_DB', 'dbo')


        # Adding referential integrity
        #tasks.establish_referential_integrity(conn_ER,'ORDERS_DIMENSIONAL_DB', 'dbo')
        
        conn_ER.close()
        logger.info("Dimensional Flow Completed Successfully")
