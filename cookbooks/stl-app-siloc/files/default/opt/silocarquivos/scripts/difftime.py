from datetime import datetime
import sys

saida = sys.argv[1]
retorno = sys.argv[2]

def retminute(saida, retorno):
    hi = saida
    hf = retorno

    fmt = '%Y-%m-%d %H:%M:%S'
    tstamp1 = datetime.strptime(hi, fmt)
    tstamp2 = datetime.strptime(hf, fmt)

    if tstamp1 > tstamp2:
        td = tstamp1 - tstamp2
    else:
        td = tstamp2 - tstamp1
        td_mins = int(round(td.total_seconds() / 60))

    return (td_mins)

t_taken = retminute(saida, retorno)
print(t_taken)
