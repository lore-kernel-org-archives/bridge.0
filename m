Message-ID: <c0bb1def0901020953v1b7722baw7f0daafdc8d02abb@mail.gmail.com>
Date: Fri, 2 Jan 2009 18:53:55 +0100
From: "Antonio Di Bacco" <a.dibacco@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_108347_15511659.1230918835172"
Subject: [Bridge] RSTPD user mode daemon segfaults with kernel 2.6.24
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

------=_Part_108347_15511659.1230918835172
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I have downloaded rstp from sourceforge and I get a segfaults when running
the daemon.
This is the line where the problem arises:

    TST(ifc->master->stp_up,);

just at the beginning of function:

  void bridge_bpdu_rcv(int if_index, const unsigned char *data, int len)

in file bridge_track.c

------=_Part_108347_15511659.1230918835172
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I have downloaded rstp from sourceforge and I get a segfaults when running the daemon. <br>This is the line where the problem arises:<br><br>&nbsp;&nbsp;&nbsp; TST(ifc-&gt;master-&gt;stp_up,);<br><br>just at the beginning of function:<br>
<br>&nbsp; void bridge_bpdu_rcv(int if_index, const unsigned char *data, int len)<br><br>in file bridge_track.c<br><br>

------=_Part_108347_15511659.1230918835172--
