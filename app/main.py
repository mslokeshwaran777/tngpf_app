from contextlib import redirect_stdout
from io import StringIO
import requests
import io

from flask import Flask, request,send_file

port = 55001

print("Trying to run a socket server on:", port)


class PythonRunner:
    __globals = {}
    __locals = {}

    def run(self, code):
        f = StringIO()
        with redirect_stdout(f):
            exec(code, self.__globals, self.__locals)
        return f.getvalue()


pr = PythonRunner()
app = Flask(__name__)


@app.route('/get_pdf', methods=['GET'])
def get_pdf():

    # suf = request.args.get('suf')
    # gpfno = request.args.get('gpfno')
    # year = request.args.get('year')
    # if not suf or not gpfno or not year:
    #    return 'Missing one or more parameters', 400
    # print(suf)

    suf = request.args.get('suf')
    gpfno = request.args.get('gpfno')
    year = request.args.get('year')

    if not suf or not gpfno or not year:
       return 'Missing one or more parameters', 400
    
    print(suf)

    url = 'https://agae.tn.nic.in/TNGPF_Reports/loginnew.aspx?Flag=A&EmpDeptcode={}&EmpgpfNo={}&ASlipYear={}'.format(suf, gpfno, year)
    res = requests.get(url)
    pdf_content = res.content
    return send_file(io.BytesIO(pdf_content), as_attachment=True, download_name='output.pdf', mimetype='application/pdf')

app.run(port=port)