Return-Path: <davem@davemloft.net>
Date: Tue, 29 Oct 2019 18:13:06 -0700 (PDT)
Message-Id: <20191029.181306.2176110994019095777.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20191029114559.28653-1-nikolay@cumulusnetworks.com>
References: <20191029114559.28653-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/7] net: bridge: convert fdbs to use
	bitops
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue, 29 Oct 2019 13:45:52 +0200

> We'd like to have a well-defined behaviour when changing fdb flags. The
> problem is that we've added new fields which are changed from all
> contexts without any locking. We are aware of the bit test/change races
> and these are fine (we can remove them later), but it is considered
> undefined behaviour to change bitfields from multiple threads and also
> on some architectures that can result in unexpected results,
> specifically when all fields between the changed ones are also
> bitfields. The conversion to bitops shows the intent clearly and
> makes them use functions with well-defined behaviour in such cases.
> There is no overhead for the fast-path, the bit changing functions are
> used only in special cases when learning and in the slow path.
> In addition this conversion allows us to simplify fdb flag handling and
> avoid bugs for future bits (e.g. a forgetting to clear the new bit when
> allocating a new fdb). All bridge selftests passed, also tried all of the
> converted bits manually in a VM.

Series applied, thanks.
