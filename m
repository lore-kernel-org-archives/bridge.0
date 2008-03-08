Message-ID: <2387247e0803071710n116bc1b6j577104db2b56b5c9@mail.gmail.com>
Date: Fri, 7 Mar 2008 20:10:46 -0500
From: "Gabriel Somlo" <gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Bridge] span/monitor port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi,

I was wondering if there's an established way to set up one or more
ports of a bridge as 'span'
or 'monitor' ports. I.e., once a port is in this state, it discards
any packets it receives, and gets
a copy of any other packet the bridge is forwarding out any other
port. Kind-of like cisco's span
monitor session.

If not, I'd be interested in having a go at it, but wanted to see if
there's anything already there
that I'm missing...

Thanks,
Gabriel
