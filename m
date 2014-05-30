Return-Path: <stephen@networkplumber.org>
Date: Fri, 30 May 2014 07:34:46 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20140530073446.14b87673@nehalam.linuxnetplumber.net>
In-Reply-To: <53869842.4060202@huawei.com>
References: <53869842.4060202@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: fix the unbalanced
 promiscuous count when add_if failed
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Wang Weidong <wangweidong1@huawei.com>
Cc: vyasevic@redhat.com, netdev <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>

On Thu, 29 May 2014 10:15:30 +0800
Wang Weidong <wangweidong1@huawei.com> wrote:

> As commit 2796d0c648c94("bridge: Automatically manage port
> promiscuous mode."), make the add_if use dev_set_allmulti
> instead of dev_set_promiscuous, so when add_if failed, we
> should do dev_set_allmulti(dev, -1).
> 
> Signed-off-by: Wang Weidong <wangweidong1@huawei.com>

Good catch.
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
