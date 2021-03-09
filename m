Return-Path: <fw@strlen.de>
Date: Tue, 9 Mar 2021 12:01:21 +0100
From: Florian Westphal <fw@strlen.de>
Message-ID: <20210309110121.GD10808@breakpoint.cc>
References: <20210309022854.17904-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309022854.17904-1-baijiaju1990@gmail.com>
Subject: Re: [Bridge] [PATCH] net: bridge: fix error return code of
 do_update_counters()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, fw@strlen.de, linux-kernel@vger.kernel.org, kadlec@netfilter.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net, pablo@netfilter.org

Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
> When find_table_lock() returns NULL to t, no error return code of
> do_update_counters() is assigned.

Its -ENOENT.

>  	t = find_table_lock(net, name, &ret, &ebt_mutex);
                                       ^^^^^

ret is passed to find_table_lock, which passes it to
find_inlist_lock_noload() which will set *ret = -ENOENT
for NULL case.
