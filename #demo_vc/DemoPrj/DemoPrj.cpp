// DemoPrj.cpp : Defines the class behaviors for the application.
//

#include "stdafx.h"
#include "DemoPrj.h"
#include "DemoPrjDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CDemoPrjApp

BEGIN_MESSAGE_MAP(CDemoPrjApp, CWinApp)
	//{{AFX_MSG_MAP(CDemoPrjApp)
	//}}AFX_MSG
	ON_COMMAND(ID_HELP, CWinApp::OnHelp)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDemoPrjApp construction

CDemoPrjApp::CDemoPrjApp()
{
}

/////////////////////////////////////////////////////////////////////////////
// The one and only CDemoPrjApp object

CDemoPrjApp theApp;

/////////////////////////////////////////////////////////////////////////////
// CDemoPrjApp initialization

BOOL CDemoPrjApp::InitInstance()
{
	// Standard initialization

	CDemoPrjDlg dlg;
	m_pMainWnd = &dlg;
	int nResponse = dlg.DoModal();
	if (nResponse == IDOK)
	{
	}
	else if (nResponse == IDCANCEL)
	{
	}

	// Since the dialog has been closed, return FALSE so that we exit the
	//  application, rather than start the application's message pump.
	return FALSE;
}
