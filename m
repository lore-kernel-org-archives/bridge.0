Return-Path: <cwang@twopensource.com>
MIME-Version: 1.0
In-Reply-To: <1438081844-18801-1-git-send-email-razor@blackwall.org>
References: <1438081844-18801-1-git-send-email-razor@blackwall.org>
Date: Tue, 28 Jul 2015 15:38:21 -0700
Message-ID: <CAHA+R7NJod_=R=Hh2Mz7nMiTxCMv=E4TMLsn2uOrS+f9gp+uHQ@mail.gmail.com>
From: Cong Wang <cwang@twopensource.com>
Content-Type: text/plain; charset=UTF-8
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
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Cong Wang <amwang@redhat.com>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, David Miller <davem@davemloft.net>

On Tue, Jul 28, 2015 at 4:10 AM, Nikolay Aleksandrov
<razor@blackwall.org> wrote:
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

Hmm?

I think it is iproute2 who forgets to set entry->state when deleting it?

                } else if (strcmp(*argv, "permanent") == 0) {
                        if (cmd == RTM_NEWMDB)
                                entry.state |= MDB_PERMANENT;

Kernel simply returns what you pass to it.

Please fix iproute2.
