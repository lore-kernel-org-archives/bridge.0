Return-Path: <dsahern@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=g8oBzmcJiwGUXDvGcXm/0jru3TFpb5KAGIgwrDHVYC8=;
 b=KBWDn9ItSVNc/Jo8C2TLo2d2SEBDpW+HtxikoK/wOOY/mZh9tUYIYjj/uswXH6qy5w
 8nYeqNNVOoQZQyqnWEKsi6y1jLlwl6N8V4Kk5dMr8lGik9Yev4DbnpaYOqRuJg+Logxv
 eaVWwobIifXbVWAI0sxtrwc0CLJRsswu3/ZdeeZ04bD1FMXgqtG4ALd4f7WEJY+0bsa8
 1GqfxQyatbsNL0hjud1ZZlRCIe59Jtnkn2Eccfbgyg4G4pWNS0OWG8BKfy+PGbWSbHz4
 J+Wd0i+hyS9MDfNNFUc+u1u8EtIllN2jVoU8Ap1Qgl43YSFTBJzs3DVrJzbbyfFpgs8N
 H9Kw==
References: <1596170660-5582-1-git-send-email-komachi.yoshiki@gmail.com>
 <5f2492aedba05_54fa2b1d9fe285b42d@john-XPS-13-9370.notmuch>
 <E2A7CC68-9235-4E97-9532-66D61A6B8965@gmail.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <8eda2f23-f526-bd56-b6ac-0d7ae82444b5@gmail.com>
Date: Wed, 5 Aug 2020 10:36:58 -0600
MIME-Version: 1.0
In-Reply-To: <E2A7CC68-9235-4E97-9532-66D61A6B8965@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [RFC PATCH bpf-next 0/3] Add a new bpf helper for FDB
	lookup
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Yoshiki Komachi <komachi.yoshiki@gmail.com>, John Fastabend <john.fastabend@gmail.com>
Cc: Song Liu <songliubraving@fb.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, Alexei Starovoitov <ast@kernel.org>, "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@chromium.org>, Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>, Martin KaFai Lau <kafai@fb.com>

On 8/5/20 4:26 AM, Yoshiki Komachi wrote:
>>
>> Just to clarify for myself. I expect that with just the helpers here
>> we should only expect static configurations to work, e.g. any learning
>> and/or aging is not likely to work if we do redirects in the XDP path.
> 
> As you described above, learning and aging don’t work at this point. 
> 
> IMO, another helper for learning will be required to fill the requirements.
> I guess that the helper will enable us to use the aging feature as well
> because the aging is the functionality of bridge fdb.

One option is to have a flag that bumps the ageing on successful lookup
and do that in 1 call. You will already have access to the fdb entry.


