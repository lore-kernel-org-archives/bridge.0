Return-Path: <adrian27oradea@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=AZcu+DLrV5ZyokUyoNRRKOIHncrsZLXI8UJ8XsDi1V0=;
	b=rwbjp2VYk3XojYfIJDCj9s33gSHOGy7X+nQrBOWjlQ3GCcRoPPao9Z56HLXj1xUrFi
	TeHkvSoEyBiddJD6BjxfpAOETQ9O8ankmTN2LqL+z9/AQxURArDhQtxYalDEg/y6gVmD
	vQTUphpVsR8xKC83ftpvn+IGG59Z1stsSUWL9u9pW/tECFIg7nPfB8T5WFsnOdiAZmhc
	vE7VACwW2z+XIYf+dGEvSembdMJnkYx6SoX9g+E4geYWR91OM3vHGzREd5Xlboqkt1NZ
	kRRzPD3MwttJ5NTDUHpoIyd9iMnSh76Qvz4kVTclDkWt0ZnK8VBaT4cJu609agBIQwSE
	M00Q==
MIME-Version: 1.0
In-Reply-To: <CA+k9h3PnKU0cvuyrd6BgYQEVHAnSm9gRDw-o2Vpc11evFGhoSA@mail.gmail.com>
References: <CA+k9h3O2OFKjoPqhN4LBnMODX=M607nwGfLiaAm+BB4T4mmEDw@mail.gmail.com>
	<20180128142826.15c9fcbf@xeon-e3>
	<CA+k9h3PnKU0cvuyrd6BgYQEVHAnSm9gRDw-o2Vpc11evFGhoSA@mail.gmail.com>
From: Adrian Pascalau <adrian27oradea@gmail.com>
Date: Mon, 29 Jan 2018 11:37:40 +0200
Message-ID: <CA+k9h3McrFUeLePQL9AV-RHcDQ7o2D7OCPiYFLv5D_waHCeeoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] ssh connection not working when ssh server is behind a
 linux bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: bridge@lists.linux-foundation.org

On Mon, Jan 29, 2018 at 9:51 AM, Adrian Pascalau
<adrian27oradea@gmail.com> wrote:
> In this 54 bytes TCP ACK frame, the Ethernet II header is 14 bytes
> long, the IP header is 20 bytes long, the TCP header is another 20
> bytes in length, and there is no TCP payload, so in total 54 bytes.
> When this frame arrives in the client side, it is 60 bytes in length,
> and it is interpreted by the Wireshark as a SSHv2 frame, because of
> the 6 additional 0x00 padding bytes in the TCP payload. I find this
> exact frame in a working ssh session, and those 6 additional 0x00
> padding bytes are correctly shows at the Ethernet II frame level.

Ok, so I found a workaround for this, even if I do not know who caused
this issue.

Basically I noticed that I have this ssh connection issue only when
the ssh client runs on a windows host. If the ssh client runs on a
linux host, the ssh connection works without any problem. So I have
compared the tcpdump for ssh connections initiated from both windows
and linux, and what I have noticed is that on centos linux, by default
the TCP stack uses timestamps in the TCP Options, and because of this,
the Ethernet frames are never below 60 bytes, while in my windows the
TCP Options timestamps are not used, and therefore some Ethernet
frames are less than 60 bytes.

So I enabled the TCP Options timestamps in windows as well, by running
the command 'netsh int tcp set global timestamps=enabled', and just
like that, the ssh started to work. Still, I do not know who is
causing this issue, and who to blame for this behavior...

Any suggestion how to identify which network element wrongly assigns
the Ethernet padding to the TCP payload is more than welcome.
