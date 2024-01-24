# test_async_code.py
import pytest
import asyncio

async def async_function():
    await asyncio.sleep(1)
    return "Hello, async!"

@pytest.mark.asyncio
async def test_async_function():
    result = await async_function()
    assert result == "Hello, async!"
