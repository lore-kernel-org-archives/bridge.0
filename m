Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:mime-version
 :content-transfer-encoding;
 bh=2xQkEOsdGwG+u+CFWHs2eb6pdZOOXhDpLU358vUysAY=;
 b=cibd0BXvekrWeRL7XEmAJ2rp5GBMqsbXiuGfvojavs69YFWqTvYXWd6u4gsSsBQn0X
 hshjVGPwA/pd89Xpu8MosA9FqOqedFuJfzebUhtk6AdRpb1MmYFhdkFKAGBPFEneF0Cn
 gIG/5TkBIFmY82N0IfSxsv9syOxK4cgMyouhTSPg/9/uT+4qMySSVLJjnM+g2eNHb2Ny
 2mwUEvM3UU8xZd2HQHUMAygwAozClXLzrpmFMAQMk3fJiWAY2qC492MxukbaS7bj2EMk
 yvdjvcJDyNdNZFFka/XGVaOrgzkn0mLSLtleXQv7e60+TR+Z2fxpuvOuBxys26AoGYm8
 K+FQ==
Date: Thu, 4 Mar 2021 09:34:46 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20210304093446.356ba862@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Minor update to bridge-utils
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

Small changes to bridge-utils to address some minor issues.

1. The default branch is main not master

2. Fixed some compiler warnings because Gcc 10 and Clang now
   do checks for string overflow.

3. Made a backup repository mirror at github.

4. Fixed version string printed

This is not a required update, none of these are important
or critical to users.

Do not intend to do any new features or serious fixes to
bridge-utils; all users should convert to iproute2/bridge command.
