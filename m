Return-Path: <mudongliangabcd@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6926140472
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8F553400B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687337410; x=1689929410;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lFfbVhmX+rRlnfYZflmEzqdlANTovVuTRalq5Bwba3g=;
 b=gUOgcNgDy6mx9Wys0vaBKGuyhmyiklAP7sAQKRn/l5VGoOm3XUNvFJ8QT6L3gx8uZk
 +YlexuNp9Pu2Q2obpiBMBPNi/LX+5GnpYYPIPyx4owgYs5Qt8m1wG2lXYddfv5DGP4pe
 Em7HdmQhWLSlN//gqyu1erJOwpZjOZXrmJu+Do8YqvGCd/Z2gY9Dg/094I12jOZzfTYM
 dsWFv94O4+QNbYxkRj6Scbqc8XzsJDUhDHWMcZ+mJnLSwCh/I7rPBf8h8RPEHZvBtTyJ
 WOR0LQq0nuag5RQRS+0q4Tw68z6PKEXzvOdqcsbe82K4I9RVYbp1auUmhZIO3RxM5UUa
 fVAg==
MIME-Version: 1.0
References: <00000000000051197705fdbc7e54@google.com>
 <20230621070710.380373-1-astrajoan@yahoo.com>
In-Reply-To: <20230621070710.380373-1-astrajoan@yahoo.com>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Wed, 21 Jun 2023 16:46:14 +0800
Message-ID: <CAD-N9QXZFMFGp3Vw4449Bx1-ttDVSF3hiwSw=e6+D096UDNfvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [syzbot] [net?] unregister_netdevice: waiting for DEV
 to become free (8)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ziqi Zhao <astrajoan@yahoo.com>
Cc: ivan.orlov0322@gmail.com, arnd@arndb.de, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, edumazet@google.com, nikolay@nvidia.com, roopa@nvidia.com, syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com, kuba@kernel.org, skhan@linuxfoundation.org, pabeni@redhat.com, davem@davemloft.net

On Wed, Jun 21, 2023 at 3:38=E2=80=AFPM 'Ziqi Zhao' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> Hi all,
>
> I'm taking a look at this bug as part of the exercice for the Linux
> Kernel Bug Fixing Summer 2023 program. Thanks to the help from my

This is an interesting program. There are many kernel crashes on the
syzbot dashboard, which needs help.

> mentor, Ivan Orlov and Shuah Khan, I've already obtained a reproduction
> of the issue using the provided C reproducer, and I should be able to
> submit a patch by the end of this week to fix the highlighted error. If
> you have any information or suggestions, please feel free to reply to
> this thread. Any help would be greatly appreciated!

Please carefully read the guidance of submitting patches to linux
kernel [1]. Be careful about your coding style before sending.

Note that, Syzbot has the feature: patch testing. You can upload and
test your own patch to confirm that your patch is working properly.

[1] https://docs.kernel.org/process/submitting-patches.html
>
> Best regards,
> Ziqi
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/20230621070710.380373-1-astrajoan%40yahoo.com.
