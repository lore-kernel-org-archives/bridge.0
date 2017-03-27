Return-Path: <marcel@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1489749179-12063-6-git-send-email-elena.reshetova@intel.com>
Date: Mon, 27 Mar 2017 16:05:34 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <54BFC171-C8E2-47BB-811D-6E9832246256@holtmann.org>
References: <1489749179-12063-1-git-send-email-elena.reshetova@intel.com>
	<1489749179-12063-6-git-send-email-elena.reshetova@intel.com>
Subject: Re: [Bridge] [PATCH 05/18] net,
 bluetooth: convert rfcomm_dlc.refcnt from atomic_t to refcount_t
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Elena Reshetova <elena.reshetova@intel.com>
Cc: peterz@infradead.org, jchapman@katalix.com, Johan Hedberg <johan.hedberg@gmail.com>, linux-x25@vger.kernel.org, bridge@lists.linux-foundation.org, James Morris <jmorris@namei.org>, 3chas3@gmail.com, Hans Liljestrand <ishkamiel@gmail.com>, keescook@chromium.org, jhs@mojatatu.com, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, linux-hams@vger.kernel.org, David Windsor <dwindsor@gmail.com>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Network Development <netdev@vger.kernel.org>, linux-decnet-user@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>, ralf@linux-mips.org, Patrick McHardy <kaber@trash.net>, linux-bluetooth@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

Hi Elena,

> refcount_t type and corresponding API should be
> used instead of atomic_t when the variable is used as
> a reference counter. This allows to avoid accidental
> refcounter overflows that might lead to use-after-free
> situations.
> 
> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> Signed-off-by: Hans Liljestrand <ishkamiel@gmail.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: David Windsor <dwindsor@gmail.com>
> ---
> include/net/bluetooth/rfcomm.h | 8 +++++---
> net/bluetooth/rfcomm/core.c    | 4 ++--
> 2 files changed, 7 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

