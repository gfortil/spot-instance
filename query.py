#!/usr/bin/env python3
# coding: utf-8

import sys, json, requests

def fetch():
    # Query data from data.tf in json format
    read_query = sys.stdin.read()
    try:
        # Parse json query object to python dictionary
        p_dict = json.loads(read_query)
        # Get dictionary value for the query key 
        size_from_query = p_dict.get('size')
        rank_from_query = p_dict.get('rank')
        # Get json object from the API for the query value
        response = requests.get("http://137.135.85.84/price/?operation=cheapest&size=%s&rank=%s" %(size_from_query,rank_from_query))
        output_json = response.json() # Return response in json format
        return_out_json = output_json['items'][0] #return the first element for items
        # Returns a json object
        output = json.dumps({str(key): str(value) for key, value in return_out_json.items()})
        # The output must be returned in stdout
        sys.stdout.write(output)
    except ValueError as e:
        sys.exit(e)

if __name__ == "__main__":
    fetch()