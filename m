Date: Fri, 29 Apr 2011 01:10:51 -0700 (PDT)
Message-Id: <20110429.011051.183061494.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <4DBA87B6020000780003ED74@vpn.id2.novell.com>
References: <4DBA830A020000780003ED5D@vpn.id2.novell.com>
	<20110429.002530.112581952.davem@davemloft.net>
	<4DBA87B6020000780003ED74@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: Module use count must be updated as
 bridges are created/destroyed
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: JBeulich@novell.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, jeffm@suse.com

From: "Jan Beulich" <JBeulich@novell.com>
Date: Fri, 29 Apr 2011 08:41:10 +0100

> You talk of rmmod on the very module, but the issue is about
> modprobe -r on a dependent module. I cannot believe you consider
> it correct that *implicit* unloading of bridge.ko should happen when
> bridges are configured.

Which module in particular depends upon bridge and causes the
problem?
