Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=date:in-reply-to:references:mime-version:content-transfer-encoding
	:subject:to:from:message-id;
	bh=Mg6Uxk2gYngckWDv9FiWBXoTzbgw2wyHoktT47rLD04=;
	b=F4myLj1Jy6JQ/1HTS0kg0Wr78g5lFuKERT9rzfIi7JhlAMbHxH9KaG2bQuu0B/A3O2
	ndvNwSPjZkXeKrH34zjYhAmT8TVxGFXhgdE3HPHEKmqR3An5iM5OFAYvSs8y6PEAdqPQ
	TsMhK/+8YSRLwqfggNcZ+ecxcVCp4ecy387Do=
Date: Mon, 12 Nov 2018 09:32:08 +0100
In-Reply-To: <00000000000047feb5057a714975@google.com>
References: <00000000000047feb5057a714975@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: nikolay@cumulusnetworks.com
Message-ID: <C0C76E26-AE73-4D51-B44A-FFC0EF629A83@cumulusnetworks.com>
Subject: Re: [Bridge] KASAN: use-after-free Read in nbp_vlan_rcu_free
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: syzbot <syzbot+04681da557a0e49a52e5@syzkaller.appspotmail.com>, bridge@lists.linux-foundation.org, davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, roopa@cumulusnetworks.com, syzkaller-bugs@googlegroups.com

On 12 November 2018 06:51:02 CET, syzbot <syzbot+04681da557a0e49a52e5@syzka=
ller=2Eappspotmail=2Ecom> wrote:
>Hello,
>
>syzbot found the following crash on:
>
>HEAD commit:    e12e00e388de Merge tag 'kbuild-fixes-v4=2E20' of
>git://git=2Ek=2E=2E
>git tree:       upstream
>console output:
>https://syzkaller=2Eappspot=2Ecom/x/log=2Etxt?x=3D14cdb6f5400000
>kernel config:=20
>https://syzkaller=2Eappspot=2Ecom/x/=2Econfig?x=3D8f215f21f041a0d7
>dashboard link:
>https://syzkaller=2Eappspot=2Ecom/bug?extid=3D04681da557a0e49a52e5
>compiler:       gcc (GCC) 8=2E0=2E1 20180413 (experimental)
>
>Unfortunately, I don't have any reproducer for this crash yet=2E
>
>IMPORTANT: if you fix the bug, please add the following tag to the
>commit:
>Reported-by: syzbot+04681da557a0e49a52e5@syzkaller=2Eappspotmail=2Ecom

Thanks, I'm about to fly out for LPC=2E Will take a look in a day=2E


