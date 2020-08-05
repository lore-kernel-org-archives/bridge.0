Return-Path: <dsahern@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OWOcCu/RdgXsCBIctAyPQWwmqwK81xNeRORnBnjCneQ=;
 b=tW1knKDE62tuWn5yeakMwnGIfDvIy8Nk4xLrt9d+xlZ0YyDTp0hfdO9t95joJp7vvZ
 Rr+5fj2ioRVHlNbtjNL9uFziyTfkS9m6bSrOaXsRADXi8VDgAZphegvBa9lTyhmpC/BW
 3brEgbOSY0tWjPyGmMovwukn4TBmQXaupVQCUTorMzToFKmuldYaJEJRmJ6fIqatSImu
 nrmyVVaeqG9e2xCRnc7TEKtNfrYGHD5YPJTs5cC4OyePzM+7V5j2mI+sMDtN7CvRgPe7
 0G+RF71204I3OsNCTMT6/vujlrH+z8AiuY8nIiy3121EPJta/NA+nf0LmKffr5fAn3+f
 oCOg==
References: <1596170660-5582-1-git-send-email-komachi.yoshiki@gmail.com>
 <1596170660-5582-3-git-send-email-komachi.yoshiki@gmail.com>
 <5970d82b-3bb9-c78f-c53a-8a1c95a1fad7@gmail.com>
 <F99B20F3-4F88-4AFC-9DF8-B32EFD417785@gmail.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <e92455ce-3a3f-7c52-1388-da40e8ceefd0@gmail.com>
Date: Wed, 5 Aug 2020 10:38:10 -0600
MIME-Version: 1.0
In-Reply-To: <F99B20F3-4F88-4AFC-9DF8-B32EFD417785@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [RFC PATCH bpf-next 2/3] bpf: Add helper to do
 forwarding lookups in kernel FDB table
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Yoshiki Komachi <komachi.yoshiki@gmail.com>
Cc: Song Liu <songliubraving@fb.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <kafai@fb.com>, David Ahern <dsahern@kernel.org>, Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@chromium.org>, Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>, "David S. Miller" <davem@davemloft.net>

On 8/4/20 5:27 AM, Yoshiki Komachi wrote:
> 
> I guess that no build errors will occur because the API is allowed when
> CONFIG_BRIDGE is enabled.
> 
> I successfully build my kernel applying this patch, and I don’t receive any
> messages from build robots for now.

If CONFIG_BRIDGE is a module, build should fail: filter.c is built-in
trying to access a symbol from module.
