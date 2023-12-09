import logging

class CustomFormatter(logging.Formatter):
    
    """ 
        Custom formatter for INFOrmative Logging
    """
    grey = "\x1b[38;20m"
    violet="\x1b[38;5;183m"
    yellow = "\x1b[33;20m"
    red = "\x1b[31;20m"
    bold_red = "\x1b[31;1m"
    reset = "\x1b[0m"
    format = "%(asctime)s - %(name)s - %(funcName)s - %(levelname)s - (%(message)s) - line: %(lineno)d"
    FORMATS = {
        logging.DEBUG: grey + format + reset,
        logging.INFO: violet + format + reset,
        logging.WARNING: yellow + format + reset,
        logging.ERROR: red + format + reset,
        logging.CRITICAL: bold_red + format + reset
    }
    def format(self, record):
        """

        Parameters
        ----------
        record : takes the record
            

        Returns
        -------
        returns formated(colored) output
        """
        log_fmt = self.FORMATS.get(record.levelno)
        formatter = logging.Formatter(log_fmt)
        return formatter.format(record)

def setup_logging(log_file_path):
    """
    Set up the logging configuration.

    Parameters
    ----------
    log_file_path : str, optional
        The path to the log file.
    """
    # Create a logger
    logger = logging.getLogger()
    logger.setLevel(logging.DEBUG)

    # Create a FileHandler and set the level to DEBUG
    file_handler = logging.FileHandler(log_file_path)
    file_handler.setLevel(logging.DEBUG)

    # Set the formatter for the FileHandler
    file_handler.setFormatter(CustomFormatter())

    # Add the FileHandler to the logger
    logger.addHandler(file_handler)

