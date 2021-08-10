Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=xiKDF5sk3nZVqiLvWljYWOnuO6utGOgyNbzwJDUY3Jc=;
 b=k/0dmRwzyl/h1/DIT/ZBTd7wOco3RdeLLqDPVQSvUXSni1cROiQM3WwzrTGiFPP69O
 vQU6yzVDX5UKBxs/7wvKmcV2fRN0/sjUWKIydN5/Hn24evQZsjaVUqr6Fr1ttcIMkWnj
 0TFQhT4wTuTbfcObgjt4v6Ins18QtMCZ1D/SgShVJluRXz196B9L43VuiHCyi08nl9Ab
 EmRjwxFl0vQFaQIPjRBMrpcpG2lv9QcwiFReDfetE+1jQlf3+krIG1bj/xWDeG9lzuTA
 Xm9NcAWUSU9h/8mVBoBQCmX/cHrXv1GbNJUFffbAuG0NyaDtf1egzKsvy/M8Qvz7wcit
 Ko6Q==
Date: Tue, 10 Aug 2021 13:42:51 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20210810104251.k7w76aqlvsvb3jcy@skbuf>
References: <CALW65jbotyW0MSOd-bd1TH_mkiBWhhRCQ29jgn+d12rXdj2pZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALW65jbotyW0MSOd-bd1TH_mkiBWhhRCQ29jgn+d12rXdj2pZA@mail.gmail.com>
Subject: Re: [Bridge] Bridge port isolation offload
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: DENG Qingfang <dqfext@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, netdev <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, Vivien Didelot <vivien.didelot@gmail.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>

On Tue, Aug 10, 2021 at 12:40:49PM +0800, DENG Qingfang wrote:
> Hi,
> 
> Bridge port isolation flag (BR_ISOLATED) was added in commit
> 7d850abd5f4e. But switchdev does not offload it currently.
> It should be easy to implement in drivers, just like bridge offload
> but prevent isolated ports to communicate with each other.
> 
> Your thoughts?

If nothing else, do add BR_ISOLATED to BR_PORT_FLAGS_HW_OFFLOAD so that
switchdev drivers which have an offloaded data plane have a chance to
reject this new bridge port flag if they don't support it yet.
