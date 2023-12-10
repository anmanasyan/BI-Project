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
        conn_DIM = tasks.connect_db_create_cursor("Database2")
        '''
        #Deleting tables if they existed
        tasks.drop_table(conn_DIM, 'order_details', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.drop_table(conn_DIM, 'employees', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.drop_table(conn_DIM, 'orders', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.drop_table(conn_DIM, 'customers', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.drop_table(conn_DIM, 'categories', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.drop_table(conn_DIM, 'products', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.drop_table(conn_DIM, 'territories', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.drop_table(conn_DIM, 'region', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.drop_table(conn_DIM, 'shippers', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.drop_table(conn_DIM, 'suppliers', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        '''
        '''
        # Creating all the tables 
        tasks.create_table(conn_DIM, 'dim_categories_scd1', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.create_table(conn_DIM, 'dim_customers_scd2', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.create_table(conn_DIM, 'dim_employees_scd1', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        #tasks.create_table(conn_DIM, 'dim_order_details', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.create_table(conn_DIM, 'fact_orders', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.create_table(conn_DIM, 'dim_products_scd1', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.create_table(conn_DIM, 'dim_region_scd1', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.create_table(conn_DIM, 'dim_region_scd4_history', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.create_table(conn_DIM, 'dim_shippers_scd1', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.create_table(conn_DIM, 'dim_suppliers_scd3', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.create_table(conn_DIM, 'dim_territories_scd1', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        tasks.create_table(conn_DIM, 'dim_territories_scd4', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        '''

        # Adding referential integrity
        #tasks.establish_referential_integrity(conn_DIM,'ORDERS_DIMENSIONAL_DB', 'dbo')

        # Updating the tables 
        tasks.update_dim_table(conn_DIM, 'dim_categories_scd1', 'ORDERS_DIMENSIONAL_DB', 'dbo','Categories', 'ORDERS_RELATIONAL_DB', 'dbo')
        tasks.update_dim_table(conn_DIM, 'dim_suppliers_scd3', 'ORDERS_DIMENSIONAL_DB', 'dbo','Suppliers', 'ORDERS_RELATIONAL_DB', 'dbo')
        tasks.update_dim_table(conn_DIM, 'dim_products_scd1', 'ORDERS_DIMENSIONAL_DB', 'dbo','Products', 'ORDERS_RELATIONAL_DB', 'dbo')
        tasks.update_dim_table(conn_DIM, 'dim_shippers_scd1', 'ORDERS_DIMENSIONAL_DB', 'dbo','Shippers', 'ORDERS_RELATIONAL_DB', 'dbo')
        tasks.update_dim_table(conn_DIM, 'dim_customers_scd2', 'ORDERS_DIMENSIONAL_DB', 'dbo','Customers', 'ORDERS_RELATIONAL_DB', 'dbo')
        tasks.update_dim_table_scd4(conn_DIM, 'dim_region_scd1', 'dim_region_scd4_history', 'ORDERS_DIMENSIONAL_DB', 'dbo','Region', 'ORDERS_RELATIONAL_DB', 'dbo')
        tasks.update_dim_table_scd4(conn_DIM, 'dim_territories_scd1', 'dim_territories_scd4_history', 'ORDERS_DIMENSIONAL_DB', 'dbo','Territories', 'ORDERS_RELATIONAL_DB', 'dbo')
    
        conn_DIM.close()
        logger.info("Dimensional Flow Completed Successfully")
