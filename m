From: "Denys Fedoryshchenko" <denys@visp.net.lb>
Date: Wed, 9 Jan 2008 08:40:35 +0200
Message-Id: <20080109063654.M87339@visp.net.lb>
In-Reply-To: <20080108085607.37ab168f@deepthought>
References: <20080108085607.37ab168f@deepthought>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=koi8-r
Subject: [Bridge] Re: [ANNOUNCE] bridge-utils 1.4
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>, bridge@linux-foundation.org
Cc: netdev@vger.kernel.org


As mentioned in
http://marc.info/?l=linux-bridge&m=113105949718826&w=2

Released package doesn't contain ./configure script

For people who know what is make on, it is easy to run autoconf , but some 
know only how to use ./configure :-)

Other than this, it is works fine with me, but i didn't test it deeply yet.

On Tue, 8 Jan 2008 08:56:07 -0800, Stephen Hemminger wrote
> Minor update to bridge-utils. Mostly fixing bugs in usage of sysfs.
> 
> Release tarball:
>   http://downloads.sourceforge.net/bridge/bridge-utils-1.4.tar.gz
> 
> Alon Bar-Lev (1):
>       Allow bridge-utils to run when no TCP/IP is available
> 
> Denys Vlasenko (1):
>       fix use of sysfs (affects 32/64 bit compat)
> 
> Jeremy Jackson (1):
>       Fix parsing of port_id's (hex).
> 
> Stephen Hemminger (3):
>       Add ignore for generated files.
>       Update gitignore
>       Use linux/if.h rather than net/if.h
> 
> -- 
> Stephen Hemminger <stephen.hemminger@vyatta.com>
> --
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
Denys Fedoryshchenko
Technical Manager
Virtual ISP S.A.L.

