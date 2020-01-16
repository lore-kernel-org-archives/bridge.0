Return-Path: <sashal@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579195628;
 bh=SCZav1MnsOnCjFEQd3NWCg1EJOw2VKjn4gRXGwkDEDs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ROP3Jt0F4x0Qqfuck0dK5r5PN9n7uUE8b/6CZW1DhJ05o2S4nuLGdzoIqTfo1QFo8
 vOLcGKXtVqplz24xf4AIc4JVvB0UiNqoZwWfo3DZroRi1OCN7VfwHuC50oqPU0zKXc
 RHAHYUT4CUvq14/YmQyybQdSTv+yTXDlWZ6Cbonc=
From: Sasha Levin <sashal@kernel.org>
Date: Thu, 16 Jan 2020 12:21:09 -0500
Message-Id: <20200116172403.18149-140-sashal@kernel.org>
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH AUTOSEL 4.14 197/371] netfilter: ebtables:
	CONFIG_COMPAT: reject trailing data after last rule
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 680f6af5337c98d116e4f127cea7845339dba8da ]

If userspace provides a rule blob with trailing data after last target,
we trigger a splat, then convert ruleset to 64bit format (with trailing
data), then pass that to do_replace_finish() which then returns -EINVAL.

Erroring out right away avoids the splat plus unneeded translation and
error unwind.

Fixes: 81e675c227ec ("netfilter: ebtables: add CONFIG_COMPAT support")
Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/netfilter/ebtables.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 35a670ec9077..a1834ad7422c 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -2164,7 +2164,9 @@ static int compat_copy_entries(unsigned char *data, unsigned int size_user,
 	if (ret < 0)
 		return ret;
 
-	WARN_ON(size_remaining);
+	if (size_remaining)
+		return -EINVAL;
+
 	return state->buf_kern_offset;
 }
 
-- 
2.20.1

