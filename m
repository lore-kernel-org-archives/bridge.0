Date: Wed, 31 Jan 2007 08:51:14 +1100
From: "Leigh Sharpe" <lsharpe@pacificwireless.com.au>
Message-ID: <H000006900128951.1170193873.mail.pacificwireless.net.au@MHS>
In-Reply-To: <m3y7nkurpg.fsf@ursa.amorsen.dk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] VLAN headers disappearing
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: benny+usenet <benny+usenet@amorsen.dk>, bridge <bridge@osdl.org>

As far as I'm aware, theres no vlan acceleration in the system anywhere. 
Tested on several different machines, all with the same result.

Regards,
             Leigh
 
Leigh Sharpe
Network Systems Engineer
Pacific Wireless
Ph +61 3 9584 8966
Mob 0408 009 502
email lsharpe@pacificwireless.com.au
web www.pacificwireless.com.au

-----Original Message-----
From: Benny Amorsen [mailto:benny+usenet@amorsen.dk] 
Sent: Wednesday, January 31, 2007 8:32 AM
To: bridge@osdl.org
Subject: Re: [Bridge] VLAN headers disappearing

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


_______________________________________________
Bridge mailing list
Bridge@lists.osdl.org
https://lists.osdl.org/mailman/listinfo/bridge


