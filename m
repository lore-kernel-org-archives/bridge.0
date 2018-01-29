Return-Path: <ser@man.szczecin.pl>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=man.szczecin.pl; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=asjzI+6js5GYss0s79EnLHwytTJCYZv9JfU8msfluZU=;
	b=qv88YstZRhcu9Kn9eFB8ZlgFgx
	ObqoAvXtGd5LSXRiqh42qKjCUVR3Ch1ytTlIA1RRPgd/6epmUtMSKLX0OYzRdGW6RO8SpXYUwYxWc
	JJ8EQWODAjPpPIOwHdR+yLIUoHghvboRoHXugkgANl4RBh2j06ooO5JHbUv0rUlLNQNvyLVrWaxlE
	F18IPqpylTJ+wQ8bpV2/vRJ2VkfFqOZGeR4t3SDyBFTFbv2E6rZ2xgcKOXR6YAI3wnvGlfrd7UxP6
	EUFR3RM1HxY9bx2+amtPfUvjM/k2wqTSeICBIWvtc3yjr0zKQOWT1/YEMkKl/4m4MCYqrqcAdxoLj
	d0A7GMbQ==;
References: <CA+k9h3O2OFKjoPqhN4LBnMODX=M607nwGfLiaAm+BB4T4mmEDw@mail.gmail.com>
	<20180128142826.15c9fcbf@xeon-e3>
From: Seweryn Niemiec <ser@man.szczecin.pl>
Message-ID: <8ada1d8f-369e-b8b8-48c1-362500e37e8f@man.szczecin.pl>
Date: Mon, 29 Jan 2018 10:42:19 +0100
MIME-Version: 1.0
In-Reply-To: <20180128142826.15c9fcbf@xeon-e3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: bridge@lists.linux-foundation.org

On 28.01.2018 23:28, Stephen Hemminger wrote:
> These symptoms sound like an MTU mismatch.
> The padding is not related. More likely, the issue is that one side
> is sending a larger frame than the MTU of the underlying interface.
> Since the bridge is a pure layer 2 interface, it has not choice
> but to drop any frame where the size is greater than the MTU.

I have a similar problem (same infrastructure and same symptoms) but with random
occurrence. Ssh session hangs randomly, usually before the login prompt is
shown), sometimes a bit later, sometimes after few days. I have MTU 1500 on all
interfaces taking part in communication. Ping of any size works and as far as I
tested, HTTP communication too, but there are problems with HTTPS.

-- 
Best regards,
Seweryn Niemiec


