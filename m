Message-ID: <48BC4A82.4000901@gmail.com>
Date: Mon, 01 Sep 2008 21:03:14 +0100
From: Cyker <cyker.lnx@gmail.com>
MIME-Version: 1.0
References: <mailman.902.1220288669.22943.bridge@lists.linux-foundation.org>
In-Reply-To: <mailman.902.1220288669.22943.bridge@lists.linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Kernel bridge not passing some traffic (VNC,
	embedded webservers)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Message-ID: <48B5D43E.9060909@gmail.com>

It turns out that the issue was caused by an MTU mismatch on the bridge.

For some reason, the bridge had an MTU of 1492, presumably something to
do with the DSL router it feeds.

Because it's impossible for bridges to fragment packets, the packets at
the full 1500 size were just being silently dropped.

It is odd that so few things on the network were being affected, but
that's computers for you :P

Sorry for the silly postings; I didn't even consider that it could be an
MTU issue since even multi-gigabyte SMB, SSH and FTP transfers were
going through!!

