Date: Thu, 27 May 2004 19:32:09 +0200
From: Santiago Garcia Mantinan <bridge@manty.net>
Subject: Re: [Bridge] [announce] bridge-utilities 1.0
Message-ID: <20040527173209.GA24075@man.manty.net>
References: <20040526105147.650ddfa9@dell_ss3.pdx.osdl.net>
	<20040527154539.GA17201@man.manty.net>
	<20040527100130.5eb8d709@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040527100130.5eb8d709@dell_ss3.pdx.osdl.net>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@osdl.org

> Okay, updated to bridge-utils-1.0.1 to fix the older 2.6 compatibility.
> Should work for pre 2.6.7 kernels now.

There is still a problem with the new version, it cannot get port info for
the ports of a bridge in the same scenario as before:

# brctl showstp br0
br0
 bridge id              8000.00010224a704
 designated root        7fff.000021002dc0
 root port                 2                    path cost                  2
 max age                  20.00                 bridge max age           200.00
 hello time                2.00                 bridge hello time         20.00
 forward delay            50.00                 bridge forward delay       5.00
 ageing time             300.00
 hello timer               0.00                 tcn timer                  0.00
 topology change timer     0.00                 gc timer                 164.21
 flags


eth0 (2)
can't get port eth0(2) info Operation not supported
 can't get port info

I think that is all.

Thanks for the quick work.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
