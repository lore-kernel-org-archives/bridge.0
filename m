Return-Path: <dan.carpenter@oracle.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=tc+I1qFTpfDdz7J58nA474ceD4IiYHXt2HPacvpjr0s=;
 b=vrN9PfqVf4yK22FqudqwJG/Nhl0I78YwekXENchKlCSD3OVfAdUrb32hXQDNsTu0eUZu
 nhzK0A8sKi1NHouaEuQDQ7j5F+dypDASuUFGEe0bted3uo0YFl2mQzPCsmYrBAnbCsmL
 sNWwMG0YVKZbE4FbCDkbx26eiBDK+Iwg1GbUOPndlnjANe5Bp1GjQwB5X6lj1e2jrXCX
 y5r9Daha36LG9wo0uS3546H3ko7FcbwTfUXW3p6+eO6LIF2MamH84+EYpk4wAjrthKiD
 V9Vkkskz/MYezVcOoUC+lgtEgaIgnImawZMV73cDstqzq9f1U2U74PvSLVxb6pWWV80N Dw== 
Date: Thu, 21 May 2020 18:01:01 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <20200521150101.GT3041@kadam>
References: <0000000000007b211005a6187dc9@google.com>
 <20200521140803.GI30374@kadam>
 <CACT4Y+bzz-h5vNGH0rDMUiuGZVX01oXawXAPbjtnNHb1KVWSvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bzz-h5vNGH0rDMUiuGZVX01oXawXAPbjtnNHb1KVWSvg@mail.gmail.com>
Subject: Re: [Bridge] KASAN: slab-out-of-bounds Read in br_mrp_parse
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev <netdev@vger.kernel.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, LKML <linux-kernel@vger.kernel.org>, horatiu.vultur@microchip.com, syzbot <syzbot+9c6f0f1f8e32223df9a4@syzkaller.appspotmail.com>, syzkaller <syzkaller@googlegroups.com>, kuba@kernel.org, David Miller <davem@davemloft.net>

On Thu, May 21, 2020 at 04:28:05PM +0200, Dmitry Vyukov wrote:
> What do you want to script? Note syzbot is not promising a specific
> stable API wrt these plain text emails. These are flattened into text
> format for human consumption and sent over unreliable media.

I just want to pipe the email to a script which fetches the tree,
checks out the hash, creates the config and does a make cscope.

regards,
dan carpenter


