from application import app
from application.service.emr_service import EmrService

from datetime import datetime
from flask import jsonify, request

emr_service = EmrService()

@app.route('/v1/emr/clusters/create')
def route_clusters_create():
    # POST env|region|config-name (yaml)
    data = emr_service.create_cluster()
    return __build_response(request, data, False)

def __build_response(request, data_response = {}, debug = True):
    """
    Build Response
    """
    if debug:
        data_request = {
            'href': request.url,
            'method': request.method,
            #'headers': request.headers,
            #'params': request.params,
            #'data': request.data,
            'timestamp': datetime.utcnow().isoformat()
        }
        return jsonify({
            'request': data_request,
            'response': data_response
        })
    else:
        return jsonify(data_response)
