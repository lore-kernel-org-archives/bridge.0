Date: Fri, 16 Apr 2004 13:43:14 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] MAC address -> interface mapping
Message-Id: <20040416134314.6ebd31ec@dell_ss3.pdx.osdl.net>
In-Reply-To: <4436.128.8.244.28.1082141218.squirrel@www.flacp.fujitsulabs.com>
References: <4436.128.8.244.28.1082141218.squirrel@www.flacp.fujitsulabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: prabha@fla.fujitsu.com
Cc: bridge@lists.osdl.org

On Fri, 16 Apr 2004 14:46:58 -0400 (EDT)
prabha@fla.fujitsu.com wrote:

> Hi,
> 
> I have a quick question - where is the <MAC address , associated
> interface> mapping stored in the bridge/brctl source code? I want to know
> on which interface (say eth0,eth1,..) a given MAC address is seen by the
> bridge.

Bridge forwarding database (kernel net/bridge/br_fdb.c)
displayed by
	brctl showmacs <bridgename>


> Could someone please help..
> Thanks!
> Prabha
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> http://lists.osdl.org/mailman/listinfo/bridge
