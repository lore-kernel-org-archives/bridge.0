Return-Path: <bigbudsupply1@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Cjkry7iGb14qhbKNWbuNwf0qGt1u2buHdKeeYzi9xTc=;
 b=kb1TSsdnm50rX8rfc6MD/7xjW4w7l+utJ9UEIn3MnVktiq9W+JOgMja36Z7gTXoz8z
 XDoSDsb6xuTDZQ1SgPpW9z9TRH1fVzEsqJGEZjgFITOIYKrolSBH2RAn9De3X/C/dyqI
 e8+DTXaOry+vj0XD5TnSHsiAizo/p/HK8NsGcA5wQNmkEB8XnQahOGnGR2FcHEeO2yQJ
 uRA79q79GUfmOPw3Y79H2dL6K84RM9ENIqnKCD0T1GBm7dPX2BFWnxO9cduv0wCw/2tu
 Lw5uV1I6lD/IwdwyO4kJZDU/Mf/yU2SrTsGQc3iKCV7tvbhJeil+FyKi7UKAcJO11zLh
 fBOw==
MIME-Version: 1.0
References: <00000000000023195505ac9d6d26@google.com>
In-Reply-To: <00000000000023195505ac9d6d26@google.com>
From: Big Budsupply <bigbudsupply1@gmail.com>
Date: Wed, 12 Aug 2020 12:40:37 +0100
Message-ID: <CAHwJNhN48+CUu09WNm=-ka1Qk+S1ch+fNLGw=BEzgYp8C_vKtg@mail.gmail.com>
Content-Type: multipart/alternative; boundary="000000000000b5c3f705acaca8ff"
Subject: Re: [Bridge] KASAN: wild-memory-access Read in do_ebt_set_ctl
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: syzbot <syzbot+64d60892aaa4d4c34812@syzkaller.appspotmail.com>
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, fw@strlen.de, linux-kernel@vger.kernel.org, kadlec@netfilter.org, syzkaller-bugs@googlegroups.com, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, kuba@kernel.org, davem@davemloft.net, pablo@netfilter.org

--000000000000b5c3f705acaca8ff
Content-Type: text/plain; charset="UTF-8"

Hello guys hope you are doing good! we are Bigbudsupply we grow and sell
the best medical marijuana product, we are looking for long time customers,
you can Email us /Bigbudsupply1@gmail.com
Text/+14432672189
Looking forward to working with you guys

On Tue, 11 Aug 2020 at 18:30 syzbot <
syzbot+64d60892aaa4d4c34812@syzkaller.appspotmail.com> wrote:

> Hello,
>
>
>
> syzbot found the following issue on:
>
>
>
> HEAD commit:    86cfccb6 Merge tag 'dlm-5.9' of git://git.kernel.org/pub/s
> ..
>
> git tree:       upstream
>
> console output: https://syzkaller.appspot.com/x/log.txt?x=1419de8a900000
>
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bcf489e08c9b8c5e
>
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=64d60892aaa4d4c34812
>
> compiler:       gcc (GCC) 10.1.0-syz 20200507
>
> userspace arch: i386
>
>
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
>
>
> IMPORTANT: if you fix the issue, please add the following tag to the
> commit:
>
> Reported-by: syzbot+64d60892aaa4d4c34812@syzkaller.appspotmail.com
>
>
>
> BUG: KASAN: wild-memory-access in memcpy include/linux/string.h:406
> [inline]
>
> BUG: KASAN: wild-memory-access in copy_from_sockptr_offset
> include/linux/sockptr.h:71 [inline]
>
> BUG: KASAN: wild-memory-access in copy_from_sockptr
> include/linux/sockptr.h:77 [inline]
>
> BUG: KASAN: wild-memory-access in compat_update_counters
> net/bridge/netfilter/ebtables.c:2222 [inline]
>
> BUG: KASAN: wild-memory-access in do_ebt_set_ctl+0x2c0/0x53b
> net/bridge/netfilter/ebtables.c:2389
>
> Read of size 80 at addr 00000000ffffffff by task syz-executor.3/9621
>
>
>
> CPU: 1 PID: 9621 Comm: syz-executor.3 Not tainted 5.8.0-syzkaller #0
>
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
>
> Call Trace:
>
>  __dump_stack lib/dump_stack.c:77 [inline]
>
>  dump_stack+0x18f/0x20d lib/dump_stack.c:118
>
>  __kasan_report mm/kasan/report.c:517 [inline]
>
>  kasan_report.cold+0x5/0x37 mm/kasan/report.c:530
>
>  check_memory_region_inline mm/kasan/generic.c:186 [inline]
>
>  check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
>
>  memcpy+0x20/0x60 mm/kasan/common.c:105
>
>  memcpy include/linux/string.h:406 [inline]
>
>  copy_from_sockptr_offset include/linux/sockptr.h:71 [inline]
>
>  copy_from_sockptr include/linux/sockptr.h:77 [inline]
>
>  compat_update_counters net/bridge/netfilter/ebtables.c:2222 [inline]
>
>  do_ebt_set_ctl+0x2c0/0x53b net/bridge/netfilter/ebtables.c:2389
>
>  nf_setsockopt+0x6f/0xc0 net/netfilter/nf_sockopt.c:101
>
>  ip_setsockopt+0x54d/0x3c10 net/ipv4/ip_sockglue.c:1436
>
>  raw_setsockopt+0x205/0x250 net/ipv4/raw.c:856
>
>  __sys_setsockopt+0x2ad/0x6d0 net/socket.c:2138
>
>  __do_sys_setsockopt net/socket.c:2149 [inline]
>
>  __se_sys_setsockopt net/socket.c:2146 [inline]
>
>  __ia32_sys_setsockopt+0xb9/0x150 net/socket.c:2146
>
>  do_syscall_32_irqs_on arch/x86/entry/common.c:84 [inline]
>
>  __do_fast_syscall_32+0x57/0x80 arch/x86/entry/common.c:126
>
>  do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:149
>
>  entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
>
> RIP: 0023:0xf7f19569
>
> Code: c4 01 10 03 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03
> 74 b0 01 10 08 03 74 d8 01 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90
> 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
>
> RSP: 002b:00000000f55130bc EFLAGS: 00000296 ORIG_RAX: 000000000000016e
>
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000000000
>
> RDX: 0000000000000081 RSI: 00000000ffffffff RDI: 0000000000000000
>
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>
> ==================================================================
>
>
>
>
>
> ---
>
> This report is generated by a bot. It may contain errors.
>
> See https://goo.gl/tpsmEJ for more information about syzbot.
>
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
>
>
> syzbot will keep track of this issue. See:
>
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
>
>
> --
>
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
>
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
>
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/00000000000023195505ac9d6d26%40google.com
> .
>
>

--000000000000b5c3f705acaca8ff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><div dir=3D"auto">Hello guys hope you are doing good! we are Bigbudsup=
ply we grow and sell the best medical marijuana product, we are looking for=
 long time customers, you can Email us /<a href=3D"mailto:Bigbudsupply1@gma=
il.com">Bigbudsupply1@gmail.com</a></div><div dir=3D"auto">Text/+1443267218=
9</div><div dir=3D"auto">Looking forward to working with you guys =C2=A0<br=
></div></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"=
gmail_attr">On Tue, 11 Aug 2020 at 18:30 syzbot &lt;<a href=3D"mailto:syzbo=
t%2B64d60892aaa4d4c34812@syzkaller.appspotmail.com">syzbot+64d60892aaa4d4c3=
4812@syzkaller.appspotmail.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">Hello,<br><br><br><br>syzbot found the following issue on:<br><b=
r><br><br>HEAD commit:=C2=A0 =C2=A0 86cfccb6 Merge tag &#39;dlm-5.9&#39; of=
 git://<a href=3D"http://git.kernel.org/pub/s" rel=3D"noreferrer" target=3D=
"_blank">git.kernel.org/pub/s</a>..<br><br>git tree:=C2=A0 =C2=A0 =C2=A0 =
=C2=A0upstream<br><br>console output: <a href=3D"https://syzkaller.appspot.=
com/x/log.txt?x=3D1419de8a900000" rel=3D"noreferrer" target=3D"_blank">http=
s://syzkaller.appspot.com/x/log.txt?x=3D1419de8a900000</a><br><br>kernel co=
nfig:=C2=A0 <a href=3D"https://syzkaller.appspot.com/x/.config?x=3Dbcf489e0=
8c9b8c5e" rel=3D"noreferrer" target=3D"_blank">https://syzkaller.appspot.co=
m/x/.config?x=3Dbcf489e08c9b8c5e</a><br><br>dashboard link: <a href=3D"http=
s://syzkaller.appspot.com/bug?extid=3D64d60892aaa4d4c34812" rel=3D"noreferr=
er" target=3D"_blank">https://syzkaller.appspot.com/bug?extid=3D64d60892aaa=
4d4c34812</a><br><br>compiler:=C2=A0 =C2=A0 =C2=A0 =C2=A0gcc (GCC) 10.1.0-s=
yz 20200507<br><br>userspace arch: i386<br><br><br><br>Unfortunately, I don=
&#39;t have any reproducer for this issue yet.<br><br><br><br>IMPORTANT: if=
 you fix the issue, please add the following tag to the commit:<br><br>Repo=
rted-by: <a href=3D"mailto:syzbot%2B64d60892aaa4d4c34812@syzkaller.appspotm=
ail.com" target=3D"_blank">syzbot+64d60892aaa4d4c34812@syzkaller.appspotmai=
l.com</a><br><br><br><br>BUG: KASAN: wild-memory-access in memcpy include/l=
inux/string.h:406 [inline]<br><br>BUG: KASAN: wild-memory-access in copy_fr=
om_sockptr_offset include/linux/sockptr.h:71 [inline]<br><br>BUG: KASAN: wi=
ld-memory-access in copy_from_sockptr include/linux/sockptr.h:77 [inline]<b=
r><br>BUG: KASAN: wild-memory-access in compat_update_counters net/bridge/n=
etfilter/ebtables.c:2222 [inline]<br><br>BUG: KASAN: wild-memory-access in =
do_ebt_set_ctl+0x2c0/0x53b net/bridge/netfilter/ebtables.c:2389<br><br>Read=
 of size 80 at addr 00000000ffffffff by task syz-executor.3/9621<br><br><br=
><br>CPU: 1 PID: 9621 Comm: syz-executor.3 Not tainted 5.8.0-syzkaller #0<b=
r><br>Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS <a href=3D"h=
ttp://rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org" rel=3D"noreferrer" tar=
get=3D"_blank">rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org</a> 04/01/2014=
<br><br>Call Trace:<br><br>=C2=A0__dump_stack lib/dump_stack.c:77 [inline]<=
br><br>=C2=A0dump_stack+0x18f/0x20d lib/dump_stack.c:118<br><br>=C2=A0__kas=
an_report mm/kasan/report.c:517 [inline]<br><br>=C2=A0kasan_report.cold+0x5=
/0x37 mm/kasan/report.c:530<br><br>=C2=A0check_memory_region_inline mm/kasa=
n/generic.c:186 [inline]<br><br>=C2=A0check_memory_region+0x13d/0x180 mm/ka=
san/generic.c:192<br><br>=C2=A0memcpy+0x20/0x60 mm/kasan/common.c:105<br><b=
r>=C2=A0memcpy include/linux/string.h:406 [inline]<br><br>=C2=A0copy_from_s=
ockptr_offset include/linux/sockptr.h:71 [inline]<br><br>=C2=A0copy_from_so=
ckptr include/linux/sockptr.h:77 [inline]<br><br>=C2=A0compat_update_counte=
rs net/bridge/netfilter/ebtables.c:2222 [inline]<br><br>=C2=A0do_ebt_set_ct=
l+0x2c0/0x53b net/bridge/netfilter/ebtables.c:2389<br><br>=C2=A0nf_setsocko=
pt+0x6f/0xc0 net/netfilter/nf_sockopt.c:101<br><br>=C2=A0ip_setsockopt+0x54=
d/0x3c10 net/ipv4/ip_sockglue.c:1436<br><br>=C2=A0raw_setsockopt+0x205/0x25=
0 net/ipv4/raw.c:856<br><br>=C2=A0__sys_setsockopt+0x2ad/0x6d0 net/socket.c=
:2138<br><br>=C2=A0__do_sys_setsockopt net/socket.c:2149 [inline]<br><br>=
=C2=A0__se_sys_setsockopt net/socket.c:2146 [inline]<br><br>=C2=A0__ia32_sy=
s_setsockopt+0xb9/0x150 net/socket.c:2146<br><br>=C2=A0do_syscall_32_irqs_o=
n arch/x86/entry/common.c:84 [inline]<br><br>=C2=A0__do_fast_syscall_32+0x5=
7/0x80 arch/x86/entry/common.c:126<br><br>=C2=A0do_fast_syscall_32+0x2f/0x7=
0 arch/x86/entry/common.c:149<br><br>=C2=A0entry_SYSENTER_compat_after_hwfr=
ame+0x4d/0x5c<br><br>RIP: 0023:0xf7f19569<br><br>Code: c4 01 10 03 03 74 c0=
 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01=
 00 51 52 55 89 e5 0f 34 cd 80 &lt;5d&gt; 5a 59 c3 90 90 90 90 eb 0d 90 90 =
90 90 90 90 90 90 90 90 90 90<br><br>RSP: 002b:00000000f55130bc EFLAGS: 000=
00296 ORIG_RAX: 000000000000016e<br><br>RAX: ffffffffffffffda RBX: 00000000=
00000003 RCX: 0000000000000000<br><br>RDX: 0000000000000081 RSI: 00000000ff=
ffffff RDI: 0000000000000000<br><br>RBP: 0000000000000000 R08: 000000000000=
0000 R09: 0000000000000000<br><br>R10: 0000000000000000 R11: 00000000000000=
00 R12: 0000000000000000<br><br>R13: 0000000000000000 R14: 0000000000000000=
 R15: 0000000000000000<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D<br><br><br><br><br><br>---<br><br>This report is generated by a bot. It=
 may contain errors.<br><br>See <a href=3D"https://goo.gl/tpsmEJ" rel=3D"no=
referrer" target=3D"_blank">https://goo.gl/tpsmEJ</a> for more information =
about syzbot.<br><br>syzbot engineers can be reached at <a href=3D"mailto:s=
yzkaller@googlegroups.com" target=3D"_blank">syzkaller@googlegroups.com</a>=
.<br><br><br><br>syzbot will keep track of this issue. See:<br><br><a href=
=3D"https://goo.gl/tpsmEJ#status" rel=3D"noreferrer" target=3D"_blank">http=
s://goo.gl/tpsmEJ#status</a> for how to communicate with syzbot.<br><br><br=
><br>-- <br><br>You received this message because you are subscribed to the=
 Google Groups &quot;syzkaller-bugs&quot; group.<br><br>To unsubscribe from=
 this group and stop receiving emails from it, send an email to <a href=3D"=
mailto:syzkaller-bugs%2Bunsubscribe@googlegroups.com" target=3D"_blank">syz=
kaller-bugs+unsubscribe@googlegroups.com</a>.<br><br>To view this discussio=
n on the web visit <a href=3D"https://groups.google.com/d/msgid/syzkaller-b=
ugs/00000000000023195505ac9d6d26%40google.com" rel=3D"noreferrer" target=3D=
"_blank">https://groups.google.com/d/msgid/syzkaller-bugs/00000000000023195=
505ac9d6d26%40google.com</a>.<br><br></blockquote></div></div>

--000000000000b5c3f705acaca8ff--
