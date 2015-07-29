Return-Path: <davem@davemloft.net>
Date: Wed, 29 Jul 2015 15:03:14 -0700 (PDT)
Message-Id: <20150729.150314.217450368845250422.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1438081844-18801-1-git-send-email-razor@blackwall.org>
References: <1438081844-18801-1-git-send-email-razor@blackwall.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] bridge: mdb: fix delmdb state in the
	notification
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: razor@blackwall.org
Cc: amwang@redhat.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, cwang@twopensource.com

From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue, 28 Jul 2015 13:10:44 +0200

> From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> 
> Since mdb states were introduced when deleting an entry the state was
> left as it was set in the delete request from the user which leads to
> the following output when doing a monitor (for example):
> $ bridge mdb add dev br0 port eth3 grp 239.0.0.1 permanent
> (monitor) dev br0 port eth3 grp 239.0.0.1 permanent
> $ bridge mdb del dev br0 port eth3 grp 239.0.0.1 permanent
> (monitor) dev br0 port eth3 grp 239.0.0.1 temp
> ^^^
> Note the "temp" state in the delete notification which is wrong since
> the entry was permanent, the state in a delete is always reported as
> "temp" regardless of the real state of the entry.
> 
> After this patch:
> $ bridge mdb add dev br0 port eth3 grp 239.0.0.1 permanent
> (monitor) dev br0 port eth3 grp 239.0.0.1 permanent
> $ bridge mdb del dev br0 port eth3 grp 239.0.0.1 permanent
> (monitor) dev br0 port eth3 grp 239.0.0.1 permanent
> 
> There's one important note to make here that the state is actually not
> matched when doing a delete, so one can delete a permanent entry by
> stating "temp" in the end of the command, I've chosen this fix in order
> not to break user-space tools which rely on this (incorrect) behaviour.
> 
> So to give an example after this patch and using the wrong state:
> $ bridge mdb add dev br0 port eth3 grp 239.0.0.1 permanent
> (monitor) dev br0 port eth3 grp 239.0.0.1 permanent
> $ bridge mdb del dev br0 port eth3 grp 239.0.0.1 temp
> (monitor) dev br0 port eth3 grp 239.0.0.1 permanent
> 
> Note the state of the entry that got deleted is correct in the
> notification.
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> Fixes: ccb1c31a7a87 ("bridge: add flags to distinguish permanent mdb entires")

Applied and queued up for -stable, thanks.
