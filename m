Date: Thu, 27 May 2004 22:27:25 +0200
From: Santiago Garcia Mantinan <bridge@manty.net>
Subject: Re: [Bridge] [announce] bridge-utilities 1.0
Message-ID: <20040527202724.GA7326@man.manty.net>
References: <20040526105147.650ddfa9@dell_ss3.pdx.osdl.net>
	<20040527154539.GA17201@man.manty.net>
	<20040527100130.5eb8d709@dell_ss3.pdx.osdl.net>
	<20040527173209.GA24075@man.manty.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040527173209.GA24075@man.manty.net>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>, bridge@osdl.org

You won't believe it, but it still fails in this last case:

br0
 bridge id              8000.00010224a704
 designated root        7fff.000021002dc0
 root port                 1                    path cost                100
 max age                  20.00                 bridge max age         200.00
 hello time                2.00                 bridge hello time       20.00
 forward delay            50.00                 bridge forward delay     5.00
 ageing time             300.00
 hello timer               0.00                 tcn timer                0.00
 topology change timer     0.00                 gc timer               161.44
 flags                  


eth0 (2)
 can't get port info

For what I see on a strace, you are going through this before printing this
last error:

lstat64("/sys/class/net/br0/brif", 0xbffff9fc) = -1 ENOENT (No such file or
directory)
...
lstat64("/sys/class/net/eth0/brport", 0xbfffe77c) = -1 ENOENT (No such file
or directory)
ioctl(3, 0x89f0, 0xbfffe980)            = -1 EOPNOTSUPP (Operation not
supported)

Hope that helps fixing this last bit.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
