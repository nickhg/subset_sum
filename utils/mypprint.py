from pprint import pprint, pformat; 

def pformat_truncated(d, first=10, last=10, width=80):
    items = list(d.items())
    
    if len(items) <= first + last:
        # If small enough, show everything
        return pformat(d, width=width, compact=True)
    
    # Get first and last items
    first_items = dict(items[:first])
    last_items = dict(items[-last:])
    
    # Format each part
    first_str = pformat(first_items, width=width, compact=True)
    last_str = pformat(last_items, width=width, compact=True)
    
    # Remove opening/closing braces
    first_str = first_str[1:-1]  # Remove { }
    last_str = last_str[1:-1]
    
    # Combine with ellipsis
    result = "{\n" + first_str + ",\n ... (" + str(len(items) - first - last) + " entries omitted) ...\n" + last_str + "\n}"
    
    return result