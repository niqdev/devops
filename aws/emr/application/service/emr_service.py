from application import app

class EmrService(object):

    def create_cluster(self):
        app.logger.debug('TODO create_cluster')
        return {
            'instance_id': 'TODO_INSTANCE_ID'
        }
    
    def destroy_cluster(self):
        app.logger.debug('TODO destroy_cluster')
        return {
            'instance_id': 'TODO_INSTANCE_ID'
        }
    
    def info_cluster(self):
        app.logger.debug('TODO info_cluster')
        return {
            'instance_id': 'TODO_INSTANCE_ID',
            'name': 'TODO_NAME'
        }
