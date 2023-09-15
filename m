Return-Path: <stephen@networkplumber.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 829B64220E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 782ED4159C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1694793555;
 x=1695398355; darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=625PTN5iP3Dr6oBoYQ7/1bjc8m/xWKXKVAqc5lWfFNw=;
 b=UHH2QGaW1M0Uq580e7rcgmUjvBBoD98UvhLRSnvTY6F3uXVRywLO9gTvyFKyMn7Urv
 OvKHIdSmGn8Z3W1WKNr7HGp5Gfg+4AjRZVbo2kAwthLgYQkP2TJ1EQ/1/NOkBw/u/i+P
 PycAbOqPcXnjp6utal3hk8/+E2smFQ2KpXZSsQqIJU4QxmJoYyz6VW9uEP7pBRk6h8iq
 5XHJUchEl58OkdPRRgUA7OBt+yhcKlU4m3068/XtckJ32Xo6VTDjtkGiq/as5JAjvxq5
 49bsxlckCvFCO7B6/rAZifmchMLDgCFOCKr80uUI6E1wVGhGdS4pvvYZo3jtomZdZqZm
 lzuA==
Date: Fri, 15 Sep 2023 08:59:12 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20230915085912.78ffd25c@hermes.local>
In-Reply-To: <844947000ac7744a3b40b10f9cf971fd15572195.1694625043.git.aclaudi@redhat.com>
References: <cover.1694625043.git.aclaudi@redhat.com>
 <844947000ac7744a3b40b10f9cf971fd15572195.1694625043.git.aclaudi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH iproute2-next 1/2] configure: add the --color
	option
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrea Claudi <aclaudi@redhat.com>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, David Ahern <dsahern@gmail.com>, Roopa Prabhu <roopa@nvidia.com>

On Wed, 13 Sep 2023 19:58:25 +0200
Andrea Claudi <aclaudi@redhat.com> wrote:

> This commit allows users/packagers to choose a default for the color
> output feature provided by some iproute2 tools.
> 
> The configure script option is documented in the script itself and it is
> pretty much self-explanatory. The default value is set to "never" to
> avoid changes to the current ip, tc, and bridge behaviour.
> 
> Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
> ---

More build time config is not the answer either.
Don't want complaints from distribution users about the change.
Needs to be an environment variable or config file.
