Return-Path: <ericwouds@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=to:references:subject:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=uQ6jWd7pXbXYJmMcN/wu3/5WUx3HDf1UbMUwwUT3sRE=;
 b=ffaxlezXtNYOmd9Wuuj+S52kq5XRKbUedXWne+5j9mGPr8QmyLawAcoWbmt0gHEbM3
 XZ7yq9EKyd2WbavUdvQ3JvsSpyVjKX1YACyiH3KT1n4JcuqExwM+ZHvxzFHTn2WUonG9
 QA6yloUiUzXIuATTJLvAFOXBZUmTjpIhJmZfzplIHzOwAS8JhVT/klrin1vzj3MkREwT
 idv69zIebv3rJleFWRQqylXxvnwpExk37Fr2NYg3MnvaEPkinfqgbEZTxj9AlY62IEP9
 qVCI/Ag3umsXrJPKOZLjx1GlKbhpjFaNjuNxtlwi+SiuA1+VE8ZyJmIagWHdwzk4AOdD
 TS8A==
References: <20200423213643.GC1054188@lunn.ch>
From: Eric Woudstra <ericwouds@gmail.com>
Message-ID: <e71e97fe-7594-67cd-4d6c-34cab81144ee@gmail.com>
Date: Fri, 18 Dec 2020 15:54:08 +0100
MIME-Version: 1.0
In-Reply-To: <20200423213643.GC1054188@lunn.ch>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Bridge] [RFC PATCH net-next] net: bridge: fix client roaming
 from DSA user port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org


Hi Andrew and Chuanhong,

What is the status of this patch?

I am running into the same problem on my wrt3200acm and wrt1900acs, 
running on linux kernel, dsa driver and ubuntu.

I tried the patch below, without any luck. Although I have conceived two 
other work-arounds, I am curious if there is a real fix for this issue.

diff -Naur a/drivers/net/dsa/mv88e6xxx/chip.c 
b/drivers/net/dsa/mv88e6xxx/chip.c
--- a/drivers/net/dsa/mv88e6xxx/chip.c    2020-10-03 11:21:32.000000000 
+0200
+++ b/drivers/net/dsa/mv88e6xxx/chip.c    2020-12-18 15:01:58.010404773 
+0100
@@ -2476,3 +2475,0 @@
-    /* Disable learning for CPU port */
-    if (dsa_is_cpu_port(ds, port))
-        reg = 0;


Regards,

Eric Woudstra


