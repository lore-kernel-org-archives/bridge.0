Message-ID: <85c88fd30804290737o33c91b94g44a53d92b2ae855d@mail.gmail.com>
Date: Tue, 29 Apr 2008 16:37:39 +0200
From: "=?ISO-8859-1?Q?S=E9bastien_JEFFROY?=" <sebastien.jeffroy.cxr@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_9001_31612220.1209479859223"
Subject: [Bridge] how to get port status (spanning tree)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

------=_Part_9001_31612220.1209479859223
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,
I'm working on an hardware switch and I try to implement spanning tree.
I need to modify the linux bridge to get bridge port status because i have
to set hardware registers in my switch.
I looked in bridge source code and I found br_log_state() function.
This function is called by br_make_forwarding() and br_make_blocking().

I plan to add some code to send IOCTLS to my switch driver when port state
change.

Is there one function that is called when state changed ?
I need to have the 5 states ?

Best Regards,
S=E9bastien JEFFROY

------=_Part_9001_31612220.1209479859223
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,<br>I&#39;m working on an hardware switch and I try to implement spa=
nning tree.<br>I need to modify the linux bridge to get bridge port status =
because i have to set hardware registers in my switch.<br>I looked in bridg=
e source code and I found br_log_state() function.<br>
This function is called by br_make_forwarding() and br_make_blocking().<br>=
<br>I plan to add some code to send IOCTLS to my switch driver when port st=
ate change.<br><br>Is there one function that is called when state changed =
?<br>
I need to have the 5 states ?<br><br>Best Regards,<br>S=E9bastien JEFFROY<b=
r>

------=_Part_9001_31612220.1209479859223--
