Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bridge] Error while trying to setup bridge, appears to be a loop
Date: Fri, 17 Feb 2006 09:45:24 -0800
Message-ID: <57F9959B46E0FA4D8BA88AEDFBE58290167361@pxtbenexd01.pxt.primeexalia.com>
From: "Gary W. Smith" <gary@primeexalia.com>
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org

Stephen, 

Thanks for the feedback.  We decided to move some switches around and
change some things.  It appears that while we were testing we had our
second box, which was not configured yet, hook to the same set of
switches.  It had bridging enabled causing our loop.  When we migrated
this box to a completed isolated environment it went away.  When we
added the second it happened again as expected.  

We made the same changes to the second node and tweak out a bunch of
other stuff (to ensure that the bridge is created and destroyed during
the linux HA sequence).  All is good.

Thanks, 

Gary Wayne Smith

> Looks like you have multiple ethers all connected on the same wire
(and
> spanning tree is off).
> In that case packets would end up looping for ever and you would see
> that message.


