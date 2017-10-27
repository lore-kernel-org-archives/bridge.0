Return-Path: <toshiaki.makita1@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=ry1u6dFP9VPVeVBN49nxl4dOmjIWDWyPAVFORKq8OOs=;
	b=V7LrDmH3PmnXGFZ8ph7dHMhiZxNvYsNow+9j978REebbO9/Jh574GNBmTl9Yiwt7Nr
	qZBXOl2rettETDVbMuR/6yakBvnBQ/KL65Vrb+qw6CYtdROyykC/0g4P2leQgu7fRf1Y
	GtwcLP5bYRoq8TpP2c83cFQrbXBvk5Dq9j4CErXF15uRuiyZvYsRJV2kyQ2hA5LGq8fp
	PcunzjMLmdSSinC7gdql7eoEGkO4LpG+lX+/+qI03gYHnqDGq9Iv03HoHQ7i/K/iBlQX
	YJ4RVl6YwGkHWnzf2O+SbIaQdQsHr6H5Jqyk1KX/9v+pLqtcOXnUqQCJobBJKoBy5ea8
	nfFg==
References: <1f6df7e3-cd05-9b96-9f45-49c433011ff2@cumulusnetworks.com>
	<1509099577-5959-1-git-send-email-nikolay@cumulusnetworks.com>
	<1509099577-5959-3-git-send-email-nikolay@cumulusnetworks.com>
From: Toshiaki Makita <toshiaki.makita1@gmail.com>
Message-ID: <01acc055-ad4e-c35b-e6b5-5f0493e9c5ac@gmail.com>
Date: Sat, 28 Oct 2017 08:34:03 +0900
MIME-Version: 1.0
In-Reply-To: <1509099577-5959-3-git-send-email-nikolay@cumulusnetworks.com>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v6 2/2] bridge: vlan: signal if
 anything changed on vlan add
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org
Cc: roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, mrv@mojatatu.com, dsa@cumulusnetworks.com, davem@davemloft.net

On 17/10/27 (金) 19:19, Nikolay Aleksandrov wrote:
> Before this patch there was no way to tell if the vlan add operation
> actually changed anything, thus we would always generate a notification
> on adds. Let's make the notifications more precise and generate them
> only if anything changed, so use the new bool parameter to signal that the
> vlan was updated. We cannot return an error because there are valid use
> cases that will be broken (e.g. overlapping range add) and also we can't
> risk masking errors due to calls into drivers for vlan add which can
> potentially return anything.
>
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Reviewed-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>

Toshiaki Makita
