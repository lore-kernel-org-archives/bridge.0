Return-Path: <gustavo@embeddedor.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cgFXzrhuRasjv4le4yADv0Z7+ShHUhX/2A3FnoweDww=; b=rU5J4TqUzLvVYwG032wvogzd0E
 /nWWn+RQwRKKAFiSaNBeh90i8nKpnwtvcuIw3jV2Zr1M4B8XKv/pUPbJXp615vCjT2UNznr+nXQm7
 4lDsKm/wuc2OZz6Had57w2G00Y35GP9XU9ofDE0DZuPto8+cz9JvCSn53/JCAUObzZxkvW1UCbl+8
 kXKQp7IbpE9/dCux20fMGa0ALcVKm+2VZ124G+V9jv0FUfvTz2JP8JLPFEln+bc/HGllHDP7hdQzT
 /nl5ZvomCgsjO6mE+0H96/kgTp5PW0HqKnrwTYYmx6ISKLs6dfNzU9kcWGm6ld+9NgquNOhEynPwK
 IUtqeU2Q==;
References: <20200220135914.GA14062@embeddedor>
 <20200302122318.ookpzldcqltlz5wx@salvia>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <8e415003-8948-a1f6-6009-39bd44e4b161@embeddedor.com>
Date: Mon, 2 Mar 2020 06:36:37 -0600
MIME-Version: 1.0
In-Reply-To: <20200302122318.ookpzldcqltlz5wx@salvia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH][next] netfilter: Replace zero-length array
 with flexible-array member
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, Jozsef Kadlecsik <kadlec@netfilter.org>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>



On 3/2/20 06:23, Pablo Neira Ayuso wrote:
> Applied, thanks.
> 

Thanks, Pablo.
--
Gustavo
