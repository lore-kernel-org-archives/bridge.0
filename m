Return-Path: <davem@davemloft.net>
Date: Sun, 16 Aug 2020 15:10:40 -0700 (PDT)
Message-Id: <20200816.151040.1591962687263069414.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200816150813.0b998607@hermes.lan>
References: <20200816202424.3526-1-linus.luessing@c0d3.blue>
 <20200816150813.0b998607@hermes.lan>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC PATCH net-next] bridge: Implement MLD Querier
 wake-up calls / Android bug workaround
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: stephen@networkplumber.org
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, gluon@luebeck.freifunk.net, openwrt-devel@lists.openwrt.org

From: Stephen Hemminger <stephen@networkplumber.org>
Date: Sun, 16 Aug 2020 15:08:13 -0700

> Rather than adding yet another feature to the bridge, could this hack be done by
> having a BPF hook? or netfilter module?

Stephen please do not quote an entire huge patch just to add a small
amount of commentary at the end.

Thank you.
