Return-Path: <davem@davemloft.net>
Date: Mon, 24 Feb 2014 19:17:01 -0500 (EST)
Message-Id: <20140224.191701.1833024589083119809.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <8ffb523682d29d344873ad09b9c27faddcb90b5f.1393142669.git.joe@perches.com>
References: <06d3e7e463c2bbfa8b5264e67daace1181ada090.1393142669.git.joe@perches.com>
	<8ffb523682d29d344873ad09b9c27faddcb90b5f.1393142669.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 2/2] bridge: netfilter: Use ether_addr_copy
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: joe@perches.com
Cc: netfilter@vger.kernel.org, coreteam@netfilter.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, stephen@networkplumber.org, bart.de.schuymer@pandora.be, netfilter-devel@vger.kernel.org, kadlec@blackhole.kfki.hu, kaber@trash.net, pablo@netfilter.org

From: Joe Perches <joe@perches.com>
Date: Sun, 23 Feb 2014 00:05:26 -0800

> Convert the uses of memcpy to ether_addr_copy because
> for some architectures it is smaller and faster.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
Applied.
