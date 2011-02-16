In-Reply-To: <20110215080334.1fbc5357@nehalam>
References: <OF0ED85024.3389DB4D-ON8525782D.0054FDD2-8525782D.00597D7B@us.ibm.com>
	<20110215080334.1fbc5357@nehalam>
MIME-Version: 1.0
From: Ravi Varun Nair <rvnair@us.ibm.com>
Message-ID: <OFE4C6DC13.EF8563EC-ON85257839.00783446-85257839.00797E76@us.ibm.com>
Date: Wed, 16 Feb 2011 17:07:04 -0500
Content-Type: multipart/alternative;
	boundary="=_alternative 00785B7F85257839_="
Subject: Re: [Bridge] Problem configuring bridge as a hub between host
 server and running VM guest
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@lists.linux-foundation.org

This is a multipart message in MIME format.
--=_alternative 00785B7F85257839_=
Content-Type: text/plain; charset="US-ASCII"

Thanks a ton Stephen. The tc mirred action worked well for mirroring the 
ip traffic from the host to the vm.



From:   Stephen Hemminger <shemminger@linux-foundation.org>
To:     Ravi Varun Nair/Marlborough/IBM@IBMUS
Cc:     bridge@lists.linux-foundation.org
Date:   02/15/2011 11:04 AM
Subject:        Re: [Bridge] Problem configuring bridge as a hub between 
host server and running VM guest



On Fri, 4 Feb 2011 11:17:29 -0500
Ravi Varun Nair <rvnair@us.ibm.com> wrote:

> What I am trying to do is have a copy of all the traffic coming in on 
the 
> physical interface be given to the VM. T

A better way is to use tc mirred action to mirror packets to a dummy or 
other
interface.

-- 


--=_alternative 00785B7F85257839_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Thanks a ton Stephen. The tc mirred action
worked well for mirroring the ip traffic from the host to the vm.</font>
<br>
<br>
<br>
<br><font size=1 color=#5f5f5f face="sans-serif">From: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Stephen Hemminger &lt;shemminger@linux-foundation.org&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">To: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Ravi Varun Nair/Marlborough/IBM@IBMUS</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Cc: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">bridge@lists.linux-foundation.org</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">02/15/2011 11:04 AM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">Re: [Bridge]
Problem configuring bridge as a hub between host server and running VM
guest</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=2>On Fri, 4 Feb 2011 11:17:29 -0500<br>
Ravi Varun Nair &lt;rvnair@us.ibm.com&gt; wrote:<br>
<br>
&gt; What I am trying to do is have a copy of all the traffic coming in
on the <br>
&gt; physical interface be given to the VM. T<br>
<br>
A better way is to use tc mirred action to mirror packets to a dummy or
other<br>
interface.<br>
<br>
-- <br>
</font></tt>
<br>
--=_alternative 00785B7F85257839_=--
