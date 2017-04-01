Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=GglY3ElDZIlvARrS7AlrZyPRQ6fXQeEjuxsHxyO3ZT0=;
	b=QIW7Hly05MRe7T3LUtUhI0V6qMAh+D3gHYmhNEdTUJvLr1cN4ikttzzcIEezankFto
	jPSyFKssb7NA7VcbJWUAiJ5xPe+Zk5KVW3pLRL4e0aSiun9SKy0YZ9jPiTJs0uR+4l7u
	6ORy+zGZNtZJfu+zqc2+hCaDVTYN0m1roklqgmc924Xo02F/gHRzGpsm4gP2DJqhnYEO
	svq+aGgspqj+8dINMiLHinc8JI7feMnrWbNbW4c4qiqnNGlgw3ISel12KWbSXB3e/d+T
	6ti2MDlAjDs//uiGC2a0WqkefpI/1hxjxtc/vKbziJVQvZeezYZBlRCcM+XuO8VAJGhg
	jilg==
Date: Sat, 1 Apr 2017 16:48:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20170401164821.036f1b41@plumbers-lap.home.lan>
In-Reply-To: <20170328190516.GA19531@singhal-Inspiron-5558>
References: <20170328190516.GA19531@singhal-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v2] net: Remove unnecessary cast on void pointer
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: simran singhal <singhalsimran0@gmail.com>
Cc: gregkh@linuxfoundation.org, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>, outreachy-kernel@googlegroups.com, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, kadlec@blackhole.kfki.hu, Patrick McHardy <kaber@trash.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, davem@davemloft.net, pablo@netfilter.org

On Wed, 29 Mar 2017 00:35:16 +0530
simran singhal <singhalsimran0@gmail.com> wrote:

> The following Coccinelle script was used to detect this:
> @r@
> expression x;
> void* e;
> type T;
> identifier f;
> @@
> (
>   *((T *)e)
> |
>   ((T *)x)[...]
> |
>   ((T*)x)->f
> |
> 
> - (T*)
>   e
> )
> 
> Unnecessary parantheses are also remove.
> 
> Signed-off-by: simran singhal <singhalsimran0@gmail.com>

Looks good

Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
