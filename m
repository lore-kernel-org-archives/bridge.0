Return-Path: <davem@davemloft.net>
Date: Thu, 31 Aug 2017 11:43:25 -0700 (PDT)
Message-Id: <20170831.114325.2027598728601121750.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1504156693-24692-1-git-send-email-roopa@cumulusnetworks.com>
References: <1504156693-24692-1-git-send-email-roopa@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: add tracepoint in
	br_fdb_update
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: roopa@cumulusnetworks.com
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, f.fainelli@gmail.com, bridge@lists.linux-foundation.org, andrew@lunn.ch

From: Roopa Prabhu <roopa@cumulusnetworks.com>
Date: Wed, 30 Aug 2017 22:18:13 -0700

> From: Roopa Prabhu <roopa@cumulusnetworks.com>
> 
> This extends bridge fdb table tracepoints to also cover
> learned fdb entries in the br_fdb_update path. Note that
> unlike other tracepoints I have moved this to when the fdb
> is modified because this is in the datapath and can generate
> a lot of noise in the trace output. br_fdb_update is also called
> from added_by_user context in the NTF_USE case which is already
> traced ..hence the !added_by_user check.
> 
> Signed-off-by: Roopa Prabhu <roopa@cumulusnetworks.com>

Applied.

Let's use dev->name for now and if the tooling can eventually
do transparent ifindex->name then we can consider redoing
a bunch of networking tracepoints.

Thanks.
