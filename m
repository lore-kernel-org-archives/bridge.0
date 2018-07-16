Return-Path: <davem@davemloft.net>
Date: Mon, 16 Jul 2018 13:58:16 -0700 (PDT)
Message-Id: <20180716.135816.2203644668997114867.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1531497949-1766-1-git-send-email-tyhicks@canonical.com>
References: <1531497949-1766-1-git-send-email-tyhicks@canonical.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v2 net-next 0/7] Make /sys/class/net per net
 namespace objects belong to container
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: tyhicks@canonical.com
Cc: bridge@lists.linux-foundation.org, gregkh@linuxfoundation.org, containers@lists.linux-foundation.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, ebiederm@xmission.com, netdev@vger.kernel.org, tj@kernel.org

From: Tyler Hicks <tyhicks@canonical.com>
Date: Fri, 13 Jul 2018 16:05:42 +0000

> Eric had previously provided feedback that he didn't favor these changes
> affecting all layers of the stack and that most of the changes could
> remain local to drivers/base/core.c. That feedback is certainly sensible
> but I wanted to send out v2 of the patch set without making that large
> of a change since quite a bit of time has passed and the bridge changes
> in the last patch of this set shows that not all of the changes will be
> local to drivers/base/core.c. I'm happy to make the changes if the
> original request still stands.

I'd like to give Eric an opportunity to review this and give feedback
before applying.

Thanks.
