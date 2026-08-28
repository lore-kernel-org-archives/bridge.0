Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3A921CFE0
	for <bridge@lists.linux.dev>; Fri, 28 Aug 2026 19:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787946286; cv=pass; b=b/9rUXFd57fY7/+i0HGOmlAqgoYAZ6Qd02wjCWQj3Yu2VfGNxcfyjaviU5pLsR2bu/2awSg0cJSw0SO3FnXc7EMjDUsfz/xyXlTjTb5r57j4M5LQPGJPmpBJnQx9tHFzSiIC2qQYs3KUNQz+0jvzF42CjJaxbsbjkK/p/JD29dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787946286; c=relaxed/simple;
	bh=ezmawUeZfIihlnCZxaj/Y+NiA51zVoKGOvpMQNGYGWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZt13qV+riKAOSfkA6XSEnwfrlHJupNbcaFuMOMZY4FE2yTolE9vCK22DYGeyna2fWI5oa+ncIrTf07hjxeGRSyd4coDeTUUGK8c+rJNHAi3SCrtpsT694MS0X4dku/QRUvE+RSJpFTQhMdWW/gPoqXSLiaY4jCa804ioXWBl/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTMGPrZs; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTMGPrZs"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-52f83889a93so12203161cf.2
        for <bridge@lists.linux.dev>; Fri, 28 Aug 2026 12:44:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787946282; cv=none;
        d=google.com; s=arc-20260327;
        b=eB0AR58XCaIZhdK1JZAfxm332VPxBnRHGQwyHFuDQX1aJA3D09+yUPImqBs7LX8IAf
         A77eYAsHz2Xm51Jx6JENuWHGLEPYUYTUWdwZwdzq/9Kd+tGpzjqAwj20FuLr81ed6yaH
         OlL5QP7dz5MdI2gMZvso8ZtiXWd7BF5DYhf1FtglL7taMXf2/h1MkfATzVY7byzCFA4D
         IKgDy/8TmcVxM8bRsHz5b4sH8aHeb/M78jWLZBgnne5TroBV1E974/bXcVyJ7VkrNqk5
         WB39l3iYs5l+XV3yxJ65SVlsa7K1PyzLPzKhy4ilK8OtKqh9Oxlz8LhP85kRRxt//wQQ
         1tmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8AGJvH8Hm8+TZBsqJqj4crWZ4Cjkk8dFFd6elusTrto=;
        fh=pHO4Ai6vvSN8+6fV58PX8C5NcKRdEfwvccd5WnJjxL0=;
        b=V31uih28ITl0rNmJJBGvY8fn91Pgyy9wfq7e7kInDVYx/SuP3J6JfQYKnRTmS7CeyA
         eDfChKljpzIlN46N6ro6BFTPo1WUClLa0o4Gxqee/FgCwBNRc/4xZULlQbKEQRD+8NTl
         gjWtt3rKbXkHGjgn8lWfYhH8lmLGY75i9igVPyxA8kgFPr/ULQMbhY96EtBB2E8rBxcA
         b9egxQAsEfUcAOiqH6eEYcohIxq5BskvdnSkKt9bngoVxImdGjTCSRU2IsJqoVjl4PP+
         y8SLZKWR/qIcvGe10PTi8JHYZ6Q7UUA36jOPwVSzhRsONjou1Gm4t3oi4Zpi+PjAEBtb
         bR/w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787946282; x=1788551082; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8AGJvH8Hm8+TZBsqJqj4crWZ4Cjkk8dFFd6elusTrto=;
        b=bTMGPrZsP7DI5syINWent65S4lb/awOV7Um9yaQwzwi3LmUdncJtTxhLrgtNDVzcVm
         ZvGFxwu7nxyqZsq27hSu7calTX9bOWOBmUNIPc5G0D0Uy4svI3oslLfZiL7MnB5T4Ljb
         jp9D94jPMvHQZKotRKmk+ioBHJAPkvxd1dglwqM6he43XS9hzCoW0idbFgxLmxqv7sV4
         05X8s0vTfd+TAwqpLndbbKvFZ/1bAO/z6HzgZPhmXya4KGK/5TYlpPwVonJc3ZldfCZO
         oLehfe4VWPydLPa8RAG2p2ylN+ALD3JLhD009HEe0N1rDzUZt1cZH+rQ89oCyIZkF40c
         Ah1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787946282; x=1788551082;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8AGJvH8Hm8+TZBsqJqj4crWZ4Cjkk8dFFd6elusTrto=;
        b=qJI1lAElI+VzorlJvKmHwGlClujnsBtMqWeCtCcEg5wCuKoixEUUb1DLkVdRLnx5pC
         cQtZUkW25vyVlv5iGt6pjsighK4r4cX3wRuk2GCabB0ZHWaaMOS7hPKuB+X8QcvMIKnu
         N4MdBNJZZhGlMjShwuR+Hi3k+6q5kL+oFPjg3refJErtbaETuraJb+Ypml/WJdeJVuyh
         Zs37D3i35qY1HXKVCHIDeFrWW1Q8F/x4fatYCBzl8RJIozmFk4MX7U6ZgiF2fYYBJOEs
         IYTxZ6xu/KQ8R+vjahJo1DqpLbWXFoOJYZ1UYmkL7P3f1MrQCY7kClNpHe+LM/jMZ+Io
         5U+w==
X-Forwarded-Encrypted: i=1; AHgh+RpnTnH61mj+qN3I2dRzjwr7BYyUlemHqPhdcePebSrG/zOQvhSyFwnxA/QWsTUeVULsk83+Rd8=@lists.linux.dev
X-Gm-Message-State: AFuF++k7J0pl6BHrhDjuxX+ITBs6VoZX20C71ObEmhUFB/bSxLWPf5Eo
	18M+WTTsyQwSziNC6VB79dCu+CoXmCVTqc2t5u53vZ3sYFa0Gy2Th6GQ7dqKIn5JL3uoibOcehl
	ge67tYAbWzIGtgkZJVV7i9atA4f8Xg70=
X-Gm-Gg: AR+sD12cS/6ozV+KWnDtQzdhDAcOJ7Dj2PEnbgFCFqMdqkn1Alsl5NN42xH+Za5Jh2o
	vitIU3+FdwE5gEBGSTFDKCQ6TPV7ioxQOA+FB46ox8g2o20xQoJ7Ei0SBc9JolGJI1odpyxZQZK
	ys713fpaZfR8jPwea+R+OSoCdYM07Izd76R/lFMtzinKldik5Q1G29xJ5FatazBkVflba5esJJM
	37dLBxaS5MOlw1wYHaTefouo6WEP6h2ROmMs6mSYKRnMSlkCvc/nJuF50lxo7B5zZaKnjQNNAKe
	C3CUDf4WxX6ZJ96rncNpdwt+RZd6izxbpXmsMprKD3Hr
X-Received: by 2002:a05:622a:282:b0:52c:dde9:5cd5 with SMTP id
 d75a77b69052e-52fb95f3111mr109878031cf.21.1787946282501; Fri, 28 Aug 2026
 12:44:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1778378864.git.zylzyl2333@gmail.com> <7198fe2845c30c60c6b3833dd78cead8c5966931.1778378864.git.zylzyl2333@gmail.com>
 <e1f1b080-cfde-4ea4-b444-b64d43778b2f@blackwall.org> <9263d4c1-0c57-4926-930b-1d701e1f17db@blackwall.org>
 <CAAAOPT8mBxW9Fd9Sr=xWAb-fa4MUHCqKaQf86-DFNqaB9Xvgng@mail.gmail.com>
 <7ffc7cdc-8140-4ea2-b3bd-c86abe6e6cff@blackwall.org> <6c1c6972-c212-4139-b629-4603a8801cbb@blackwall.org>
In-Reply-To: <6c1c6972-c212-4139-b629-4603a8801cbb@blackwall.org>
From: Yuan Tan <yuantan098@gmail.com>
Date: Fri, 28 Aug 2026 12:44:31 -0700
X-Gm-Features: AcwNN1VGS688MXKgT72PsJhBCbqzV58ouNrjMVRWyL1dcGe6AdTVLI7Yz0t9dm8
Message-ID: <CAPuPA7KykYqE71P+7-7=1A50S1H3Ksi7ONk+kb_xR0Ep8HKBaw@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: bridge: cfm: use a per-bridge frame type
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Yilin Zhu <zylzyl2333@gmail.com>, Ren Wei <n05ec@lzu.edu.cn>, bridge@lists.linux.dev, 
	netdev@vger.kernel.org, idosch@nvidia.com, horatiu.vultur@microchip.com, 
	kuba@kernel.org, henrik.bjoernlund@microchip.com, yifanwucs@gmail.com, 
	tomapufckgml@gmail.com, bird@lzu.edu.cn, ronbogo@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 3:23=E2=80=AFAM Nikolay Aleksandrov <razor@blackwal=
l.org> wrote:
>
> On 12/05/2026 11:09, Nikolay Aleksandrov wrote:
> > On 12/05/2026 08:21, Yilin Zhu wrote:
> >> On Sun, 10 May 2026 at 04:40, Nikolay Aleksandrov <razor@blackwall.org=
> wrote:
> >>>
> >>> On 10/05/2026 13:05, Nikolay Aleksandrov wrote:
> >>>> On 10/05/2026 12:15, Ren Wei wrote:
> >>>>> From: Yilin Zhu <zylzyl2333@gmail.com>
> >>>>>
> >>>>> CFM registers a bridge frame handler when the first MEP is created =
and
> >>>>> unregisters it when the last MEP is deleted. The registered object =
also
> >>>>> contains the hlist_node used by the bridge-local frame_type_list.
> >>>>>
> >>>>> The CFM frame type is currently global, so enabling CFM on multiple
> >>>>> bridges links the same hlist_node into multiple bridge-local lists.=
 A
> >>>>> later unregister on one bridge can then operate on list state belon=
ging
> >>>>> to another bridge.
> >>>>>
> >>>>> Move the CFM frame type into struct net_bridge and register/unregis=
ter
> >>>>> the bridge-owned object. This keeps frame handler list membership l=
ocal
> >>>>> to the bridge while preserving the existing first-MEP/last-MEP life=
time.
> >>>>>
> >>>>> Fixes: dc32cbb3dbd7 ("bridge: cfm: Kernel space implementation of C=
FM. CCM
> >>>>> frame RX added.")
> >>>>> Cc: stable@kernel.org
> >>>>> Reported-by: Yuan Tan <yuantan098@gmail.com>
> >>>>> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> >>>>> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> >>>>> Reported-by: Xin Liu <bird@lzu.edu.cn>
> >>>>> Co-developed-by: Peihan Liu <ronbogo@outlook.com>
> >>>>> Signed-off-by: Peihan Liu <ronbogo@outlook.com>
> >>>>> Signed-off-by: Yilin Zhu <zylzyl2333@gmail.com>
> >>>>> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> >>>>> ---
> >>>>>    net/bridge/br_cfm.c     | 14 ++++++--------
> >>>>>    net/bridge/br_private.h | 18 +++++++++++-------
> >>>>>    2 files changed, 17 insertions(+), 15 deletions(-)
> >>>>>
> >>>>
> >>>> I think MRP suffers from the same bug, but I also think we can conta=
in the
> >>>> fix within the packet type structure instead of making the already h=
uge
> >>>> struct net_bridge even bigger. Also, linking a struct within net_bri=
dge
> >>>> to a list within the same net_bridge looks weird.
> >>>>
> >>>> IMO br_add_frame should take a type & a frame_handler, allocate a br=
_frame_type
> >>>> dynamically and link it, then br_del_frame should take a type instea=
d of a ptr
> >>>> and remove that frame type and free it with kfree_rcu. That would re=
quire
> >>>> br_add_frame return value to be checked in the respective cfm/mrp fu=
nctions.
> >>>> Warnings for already existing types on add or missing types on del s=
hould be
> >>>> added.
> >>>>
> >>>
> >>> Actually I have a better idea since these handlers can be added only =
once per
> >>> bridge, we can do away with a simple bitmask (e.g. use net_bridge's o=
ptions
> >>> which is in a Rx hot cache line) and even reduce net_bridge size whil=
e fixing
> >>> these bugs, and also remove a conditional from the fast-path when CFM=
/MRP are
> >>> not compiled in. Would you like me to prepare it or do you want to gi=
ve it a go?
> >>>
> >>
> >> Hi Nik,
> >>
> >> Thanks for the suggestion.
> >>
> >> I'll give it a go. IIUC, the idea is to remove the shared
> >> br_frame_type list entries for CFM/MRP, track their per-bridge enable
> >> state with bridge option bits, and dispatch the CFM/MRP handlers direc=
tly
> >> from the receive path when the corresponding EtherType and option bit
> >> match.
> >>
> >> I'll include MRP in v2.
> >>
> >> Thanks,
> >> Yilin
> >>
> >
> > Great, thank you. That should simplify the code and give us 8 bytes of =
Rx hot
> > cache line back. The important point is that there haven't been any new
> > handlers since these were added back in 2020, and also these are not
> > common, so making their impact on the fast-path as small as possible
> > while fixing the bug sounds good.
> >
> > A quick & dirty sketch of the fixes gives me:
> > 5 files changed, 47 insertions(+), 66 deletions(-)
> >
> > That can probably be improved (i.e. more deletions).
> >
> > Just please make sure that if CFM/MRP are not enabled in .config, they
> > would not affect the fast-path at all.
> >
> > Cheers,
> >   Nik
> >
>
> Hi Yilin,
> Are you still considering fixing these problems? A few months passed sinc=
e
> we last spoke.
>
> Cheers,
>   Nik
>
>

Hi Nik,

I=E2=80=99m very sorry for the long delay. Yilin has gone back to continue =
his
studies and unfortunately no longer has the time to finish this patch.

There was also an issue on my side in keeping track of this work, and
I failed to notice that the patch had been left without a follow-up
for so long. I apologize for that.

I can take over the patch, address the remaining feedback, and send a
new version. That said, I=E2=80=99m not sure whether it might actually be
easier for you to make the changes directly, if you are willing to do
so. I=E2=80=99ve heard from maintainers that reviewing and iterating on
someone else=E2=80=99s patch can sometimes take more effort than simply mak=
ing
the fix themselves, so I wanted to ask which approach you would
prefer.

If you would prefer to fix the issue directly, could you please
include the following tags?
Reported-by: zylzyl2333@gmail.com
Reported-by: vega@nebusec.ai

Otherwise, I=E2=80=99m happy to take over and prepare the next revision.
What would you prefer?

Best,
Yuan
