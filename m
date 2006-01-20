Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 19 Jan 2006 21:05:01 -0500
Message-ID: <425BE87409B6BA49954C7D375C69F9ED03270833@ms09.mse4.exchange.ms>
From: "Elangovan, Anush" <anush@fireeye.com>
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Bridging multiple tap interfaces
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Is it possible to bridge multiple "tap" interfaces in Linux?

When two tap interfaces are bridged together they are unable to "see"
each other but they can bridge to external Ethernet interfaces or the
hosts IP attached on the bridge. 

I saw some mention in the mailing list archives on bridging two user
space processes but it didn't seem to have any conclusion. I also
noticed some other wireless interfaces and tap interfaces are not able
to be bridged. 

http://lists.osdl.org/pipermail/bridge/2005-December/001215.html


So does the bridging code differentiate between the pseudo-devices
before making forwarding decisions?

Thanks
Anush


