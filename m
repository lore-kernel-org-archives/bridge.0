Return-Path: <stephen@networkplumber.org>
Date: Mon, 4 Aug 2014 08:45:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20140804084532.6b84524c@haswell.linuxnetplumber.net>
In-Reply-To: <1407158554-17384-1-git-send-email-mst@redhat.com>
References: <1407158554-17384-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: remove a useless comment
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

On Mon, 4 Aug 2014 15:22:40 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> commit 6cbdceeb1cb12c7d620161925a8c3e81daadb2e4
>     bridge: Dump vlan information from a bridge port
> introduced a comment in an attempt to explain the
> code logic. The comment is unfinished so it confuses more
> than it explains, remove it.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Stephen Hemminger <stephen@networkplumber.org>

