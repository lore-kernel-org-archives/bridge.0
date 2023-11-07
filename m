Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC67F315A6
	for <bridge@lists.linux-foundation.org>; Tue,  7 Nov 2023 19:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PjRiKfOt"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 36BC2608F5
	for <bridge@lists.linux-foundation.org>; Tue,  7 Nov 2023 19:39:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 36BC2608F5
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=PjRiKfOt
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aVVbif-3XUVq for <bridge@lists.linux-foundation.org>;
	Tue,  7 Nov 2023 19:39:12 +0000 (UTC)
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3865960B3D
	for <bridge@lists.linux-foundation.org>; Tue,  7 Nov 2023 19:39:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3865960B3D
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-495eb6e2b80so2072628e0c.1
        for <bridge@lists.linux-foundation.org>; Tue, 07 Nov 2023 11:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1699385951; x=1699990751; darn=lists.linux-foundation.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zXEcLUghlLTJymbpqjqsHkaI+GT+6cey5xs0Be3U1zU=;
        b=PjRiKfOtawm2qyrUPZUc35ssvwlooexEFX+l55eO7QxuqC/35R26QOl8BfpbROeVaC
         gon5pel/rl35i6OV4+wzitD6VQy3Ox7f/+VEgU00HRI3+lE+umlB67CB1J0CvpBcAxuy
         stQl01m0eF49KvzBvj8gAMl5Oj4OauvKnyKEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699385951; x=1699990751;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zXEcLUghlLTJymbpqjqsHkaI+GT+6cey5xs0Be3U1zU=;
        b=QWrSi3ZC8548plcsggvqi3PzxMjCAaHDheRGQ8gjmAS7QEQnYxBoXlmQcieUbXmWbR
         qjXkIdPQ2wUPVAq2ldLNsOaQUOPzsEXZgmohBzeOYIzfd/Ecw6SZK8a7EBByz6yNlWMs
         q7yj0tnpROlBJMPVmvd7wgGr6mjF/egN/JRdqllWWHFQp7cgcE8eh1RYg0qiUIcd4hwS
         6VLrq+s1aTNYF2AZDLs0rOgEiiKymlDEFJ1kAFSeYJ2pN3S5whJWiM359OgSMPsySb2z
         F5i1m6t26OnaqoWMKIdDZIbGJWdPDYsS2gI4adCoVFlief3HLDSXUVgO5aeag1hbC2KV
         a2Rw==
X-Gm-Message-State: AOJu0YwVjL9pIMEnQ3WuxSX0zocwWAaTYl4vRm3hKeEqRLZ8J08QcF5i
	TJlublasvR9IWoJkmgKHhxBnUMsKvKl9JkywuRbyLMwlVpEQrnbF+Bc=
X-Google-Smtp-Source: AGHT+IH0Xa6ev6ePB36p0OuSuGjB1No46IuwuGhMFEWQol9dPb7hLWHfmmkfJioJywyACiIZNXaP1Ap0LCUmJUqGB5c=
X-Received: by 2002:a1f:aa84:0:b0:4a8:fcf8:9c77 with SMTP id
 t126-20020a1faa84000000b004a8fcf89c77mr21132433vke.6.1699385950463; Tue, 07
 Nov 2023 11:39:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231101-enormous-salmon-of-coffee-7ebb9a@nitro>
In-Reply-To: <20231101-enormous-salmon-of-coffee-7ebb9a@nitro>
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date: Tue, 7 Nov 2023 14:38:59 -0500
Message-ID: <CAMwyc-Swea546bwdVebLrM1i5UNvZmxWaVyGBhi=TMUwbHKoJg@mail.gmail.com>
Subject: Re: PSA: the bridge list will be moving to lists.linux.dev
To: bridge@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Nov 2023 at 16:10, Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
> The mailman-2 system running on lists.linux-foundation.org is being
> decommissioned, so all lists currently hosted there will be found new homes.
> *On November 7*, The bridge list will be migrated to live on lists.linux.dev,
> but the impact of this move should be minor:

Hi, all:

This work is complete -- the new list address is
bridge@lists.linux.dev, but the old address will continue to work for
the foreseeable future.

As a reminder, below is the impact of this migration:

> 1. The new canonical list address will be bridge@lists.linux.dev.
>
> 2. *The old address will continue to work* for the foreseeable future, so any
>    existing conversations can continue and any new messages sent to the old
>    list address will be properly delivered to all subscribers.
>
> 3. All members will be automatically subscribed to the new list, so no action
>    is required on anyone's part to keep receiving list mail.
>
> 4. The list will be archived on https://lore.kernel.org/bridge/ with all prior
>    archives automatically imported.
>
> 5. The List-ID header will change, regardless to which address the message is
>    sent:
>
>    before: List-Id: <bridge.lists.linux-foundation.org>
>     after: List-Id: <bridge.lists.linux.dev>
>
>    You will need to update your filtering rules if you filter based on the
>    contents of that header (on or after November 7).
>
> 6. The mailman footer will no longer be added to message bodies and the
>    subject will no longer be modified to insert [bridge] (because this
>    violates DMARC).
>
> 7. Subscribing and unsubscribing will be done using the mlmmj supported
>    commands, documented at https://subspace.kernel.org/subscribing.html

The list is now archived on https://lore.kernel.org/bridge/.

If something isn't working or looking right, please reach out to
helpdesk@kernel.org.

-K
