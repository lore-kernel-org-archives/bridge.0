From: Benny Amorsen <benny+usenet@amorsen.dk>
Date: 30 Jan 2007 22:31:39 +0100
Message-ID: <m3y7nkurpg.fsf@ursa.amorsen.dk>
References: <H000006900127bb1.1170115520.mail.pacificwireless.net.au@MHS>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@sea.gmane.org>
Subject: Re: [Bridge] VLAN headers disappearing
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

>>>>> "LS" == Leigh Sharpe <lsharpe@pacificwireless.com.au> writes:

LS> Results in lots of log entries in /var/log/messages, as one would
LS> expect. However,

LS> ebtables -F ebtables -A FORWARD -p 8021q --log -j ACCEPT

LS> Results in absolutely nothing in /var/log/messages, which would
LS> indicate that at some point, the VLAN headers are disappearing
LS> from my bridged packets.

Cards with hardware accelerated VLAN's eat the 802.1q headers. It is
very annoying. You can recompile the driver with VLAN acceleration
turned off in most cases, but that is hardly a nice solution.


/Benny


