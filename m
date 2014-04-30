Return-Path: <ratheesh.ksz@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=Og5SvkUF3buiOk5JFY3NeYMdS4fD7BNxA3m7Ff9/VFk=;
	b=Dydty2cXm5HzXChl7bl3leEHrBLGyx68pJqySspI2x5CqagIXXCssOiMsd6B4jpaNO
	KzwKqL5KoBaxUZ7oPiQUiHLw5h5tdBdDMU79BfP7mU8cMVNnW+Ssz5wxGC55Uwfn/9xn
	GZ6KeGE4O/496BIsfzGeskhG/Fj5iG6Jo/aX++MxJKDFsmEMWD6iSAQAF/6/wKDcoYk0
	QuUleuaqmiEA4zDQym/KWBoGvF88jU+EmDXP/z0ntl6K1lShr9nJIQX5ci2haROtkKf/
	yoj8vUnmYKAa/kZYkIycbHoimEcFeucOJklFB9csA8o05m4vUl3KrRUMnYb0u9OruY5Y
	kH+Q==
MIME-Version: 1.0
Date: Wed, 30 Apr 2014 12:21:42 +0530
Message-ID: <CAGZFCEHmfEKetRDKT8vh3sW_68QEt_CLxMPTQwgRg9nC6CRezg@mail.gmail.com>
From: ratheesh kannoth <ratheesh.ksz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Bridge] performance same ?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netperf-talk@netperf.org, bridge@lists.linux-foundation.org, kvm@vger.kernel.org

i have two  ubunutu vm started using virt-manager  say vm1 and vm2.
Both has one interface has one network interface ( vnet0 and vnet1
respectively ) and they are bridged using  virbr0 ( using brctl
command ).

i excuted   command
netperf  -H  "vm2 ip address"           from  vm1 ubuntu machine.  i
got result =  164.

I wrote a usespace program - which creates  two tap devices  ( tap1
and tap2) and will read from tap1 and write to tap2 ( and vice versa )
 using epoll system call.  i removed vibr0 brdige.  i bridged ( using
brctl )  tap1 and vnet0  together  and tap2 and vnet1 together. i
repeated above  netperf test. I am getting same 164.  In the first
test, i avoided 2 userspace copies and  2 read system call and 2 write
system call.  why performance is same in both case ? any hint is
really appreciated ?

Thanks,
Ratheesh
